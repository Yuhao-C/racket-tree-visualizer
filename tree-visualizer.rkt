#lang racket

(require pict/tree-layout)
(require pict)

(provide visualize)

(define (binary->layout tree)
  (cond
    [(empty? tree) (tree-layout #:pict (blank))]
    [else (define v (struct->vector tree))
          (define key (vector-ref v 1))
          (define left (vector-ref v 2))
          (define right (vector-ref v 3))
          (tree-layout #:pict (text (~v key) null 14 0)
                       (if (empty? left)
                           #f
                           (binary->layout left))
                       (if (empty? right)
                           #f
                           (binary->layout right)))]))

(define (cons->generic tree) tree)

(define (list->generic tree)
  (cond
    [(empty? tree) empty]
    [(not (list? tree)) tree]
    [else (cons (car tree) (map list->generic (cadr tree)))]))

(define (struct->generic tree)
  (cond
    [(empty? tree) empty]
    [else (begin
            (define v (struct->vector tree))
            (define key (vector-ref v 1))
            (define children (vector-ref v 2))
            (cons key (map struct->generic children)))]))

(define (tree->tree-layout tree)
  (cond
    [(empty? tree)
     (tree-layout #:pict (blank))]
    [(not (list? tree))
     (tree-layout #:pict (text (~v tree) null 14 0))]
    [else
     (apply tree-layout
            #:pict (text (~v (car tree)) null 14 0)
            (map tree->tree-layout (cdr tree)))]))

(define handler-hash (hash
                      'binary-tree binary->layout
                      'cons-tree cons->generic
                      'list-tree list->generic
                      'struct-tree struct->generic))

(define (visualize tree-type tree)
  (pict->bitmap
   (naive-layered
    (if (symbol=? tree-type 'binary-tree)
        ((hash-ref handler-hash tree-type) tree)
        (tree->tree-layout
         ((hash-ref handler-hash tree-type) tree))))))