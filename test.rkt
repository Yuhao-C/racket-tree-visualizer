;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t write repeating-decimal #f #t none #f () #f)))
(require "tree-visualizer.rkt")


(define-struct node (key left right))
(define-struct alt-node (left right key))


(define n (make-node 5
                     (make-node 3
                                (make-node 1 empty empty)
                                (make-node 4 empty empty))
                     (make-node 8
                                (make-node 7
                                           (make-node 6 empty empty)
                                           empty)
                                (make-node 10
                                           (make-node 9 empty empty)
                                           (make-node 11
                                                      empty
                                                      (make-node 15
                                                                 (make-node 13
                                                                            (make-node 12 empty empty)
                                                                            empty)
                                                                 (make-node 16 empty empty)))))))

(define n-alt (make-alt-node
               (make-alt-node
                (make-alt-node empty empty 1)
                (make-alt-node empty empty 4)
                3)
               (make-alt-node
                (make-alt-node
                 (make-alt-node empty empty 6)
                 empty
                 7)
                (make-alt-node
                 (make-alt-node empty empty 9)
                 (make-alt-node
                  empty
                  (make-alt-node
                   (make-alt-node
                    (make-alt-node empty empty 12)
                    empty
                    13)
                   (make-alt-node empty empty 16)
                   15)
                  11)
                 10)
                8)
               5))


(visualize-binary-tree n)
(visualize-binary-tree empty)
(visualize-binary-tree n-alt '(left right key))


(define tree1 '(a b (c d ("E" f) g) h i (j k l m)))
(define tree2 '(+ (* 4 2 3) (+ (* 5 1 2) 2)))
(define tree3 (list (make-node 'test "node" 1)
                    (make-node 'test "node" 2)
                    (make-node 'test "node" 3)))

(visualize-tree/cons tree1)
(visualize-tree/cons empty)
(visualize-tree/cons 'a)
(visualize-tree/cons tree2)
(visualize-tree/cons tree3)


(define tree11 '(a (b (c (d ("E" (f)) g)) h i (j (k l m)))))
(define tree12 '(+ ((* (4 2 3)) (+ ((* (5 1 2)) 2)))))
(define tree13 (list (make-node 'test "node" 1)
                    (list (make-node 'test "node" 2)
                    (make-node 'test "node" 3))))

(visualize-tree/list tree11)
(visualize-tree/list tree12)
(visualize-tree/list tree13)


(define-struct generic-node (key children))
(define tree24 (make-generic-node 'a
                    (list (make-generic-node 'b
                                             (list (make-generic-node 'c empty)
                                                   (make-generic-node 'd empty)
                                                   (make-generic-node "E" empty)))
                          (make-generic-node 'f empty)
                          (make-generic-node 'g empty)
                          (make-generic-node 'h empty)
                          (make-generic-node 'i empty))))
(visualize-tree/struct tree24)