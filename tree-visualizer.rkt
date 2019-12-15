#lang racket
(require pict/tree-layout)
(require pict)
(define-struct unde-tree (left right))
(define-struct de-tree (left right val))

(provide unde-tree de-tree visualize-decorated-tree visualize-undecorated-tree)

(define (visualize-undecorated-tree t)
  (if (empty? t)
      (blank)
      (naive-layered (undecorated-helper t))))

(define (undecorated-helper t)
  (cond
    [(and (empty? (unde-tree-left t))
          (empty? (unde-tree-right t))) (tree-layout #f #f)]
    [(empty? (unde-tree-left t)) (tree-layout #f (undecorated-helper (unde-tree-right t)))]
    [(empty? (unde-tree-right t)) (tree-layout (undecorated-helper (unde-tree-left t)) #f)]
    [else (tree-layout (undecorated-helper (unde-tree-left t)) (undecorated-helper (unde-tree-right t)))]))

(define (visualize-decorated-tree t)
  (if (empty? t)
      (blank)
      (naive-layered (decorated-helper t))))

(define (decorated-helper t)
  (cond
    [(and (empty? (de-tree-left t))
          (empty? (de-tree-right t))) (tree-layout #:pict (text (number->string (de-tree-val t))))]
    [(empty? (de-tree-left t)) (tree-layout #:pict (text (number->string (de-tree-val t))) #f (decorated-helper (de-tree-right t)))]
    [(empty? (de-tree-right t)) (tree-layout #:pict (text (number->string (de-tree-val t))) (decorated-helper (de-tree-left t)) #f)]
    [else (tree-layout #:pict (text (number->string (de-tree-val t))) (decorated-helper (de-tree-left t)) (decorated-helper (de-tree-right t)))]))