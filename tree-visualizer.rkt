#lang racket

(require pict/tree-layout)
(require pict)

(provide visualize)

(define (binary->generic tree)
  (cond
    [(empty? tree) empty]
    [else (begin
            (define v (struct->vector tree))
            (define key (vector-ref v 0))
            (define left (vector-ref v 1))
            (define right (vector-ref v 2))
            (cons key (list (binary->generic left) (binary->generic right))))]))

(define (cons->generic tree) tree)

(define (list->generic tree)
  (cond
    [(empty? tree) empty]
    [(not (list? tree)) tree]
    [else (cons (car tree) (map list->generic (cadr tree)))]))

(define (struct->generic tree)
  (cond
    [(empty? tree) empty]
    [(not (list? tree)) tree]
    [else (begin
            (define v (struct->vector tree))
            (define key (vector-ref v 0))
            (define children (vector-ref v 1))
            (cons key (map struct->generic children)))]))

(define (tree->tree-layout tree)
  (cond
    [(empty? tree)
     (tree-layout #:pict (blank))]
    [(not (list? tree))
     (tree-layout #:pict (text (~v tree)))]
    [else
     (apply tree-layout
            #:pict (text (~v (car tree)))
            (map tree->tree-layout (cdr tree)))]))

(define handler-hash (hash
                        'binary-tree binary->generic
                        'cons-tree cons->generic
                        'list-tree list->generic
                        'struct-tree struct->generic))

(define (visualize tree-type tree)
  (println
    (naive-layered
      (tree->tree-layout
        ((hash-ref handler-hash tree-type) tree)))))