#lang racket

(require pict/tree-layout)
(require pict)
(define-struct unde-tree (left right))
(define-struct de-tree (left right val))

(provide visualize-binary-tree
         unde-tree de-tree
         visualize-decorated-tree
         visualize-undecorated-tree)


;; (bt->tree-layout tree order) produces a tree-layout from tree;
;;   this is only used as a helper of visualize-binary-tree
;; bt->tree-layout: BinaryTree (listof Sym) -> Tree-Layout
(define (bt->tree-layout tree order)
  (if (empty? tree)
      (tree-layout #:pict (blank) #f #f)
      (local
        [(define h (make-hash (map cons order (build-list 3 add1))))
         (define v (struct->vector tree))
         (define key (vector-ref v (hash-ref h 'key)))
         (define left (vector-ref v (hash-ref h 'left)))
         (define right (vector-ref v (hash-ref h 'right)))]
        (tree-layout #:pict (text (number->string key))
                     (if (empty? left)
                         #f
                         (bt->tree-layout left order))
                     (if (empty? right)
                         #f
                         (bt->tree-layout right order))))))


;; (visualize-binary-tree tree [form]) produces a visualization of tree
;;   with nodes defined as struct in the form (key left right);
;;   an optional argument [form] can be supplied to specify the form of
;;   node struct
;; visualize-binary-tree: BinaryTree [(listof Sym)] -> Void
(define (visualize-binary-tree tree [form '(key left right)])
  (println (naive-layered (bt->tree-layout tree form))))


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