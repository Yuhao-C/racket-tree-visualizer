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
