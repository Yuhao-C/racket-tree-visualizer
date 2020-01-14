# racket-tree-visualizer

A tree-visualizer for Racket programming language

![Visualization of a binary expression tree](title.png)

## Installation

1. Copy the file `tree-visualizer.rkt` into the directory that contains your Racket files
2. Paste the following line at the top of your code:

```scheme
(require "tree-visualizer.rkt")
```

## Usage

```scheme
(visualize tree-type tree)
```

Prints a tree nicely in the interactive window.

- `tree-type` _Sym_ - one of the following:
  - `'binary-tree` - binary trees in the form of `(make-node key left right)`
  - `'cons-tree` - trees in the form of `(cons key (listof children))`
  - `'list-tree` - trees in the form of `(list key (listof children))`
  - `'struct-tree` - trees in the form of `(make-node key (listof children))`
- `tree` _(anyof binary-tree cons-tree list-tree struct-tree)_ - a tree in one of the aforementioned forms

## Example

```scheme
(define example-bt
  (make-node 5
             (make-node 3
                        (make-node 1 empty empty)
                        (make-node 4 empty empty))
             (make-node 8
                        (make-node 7 empty empty)
                        (make-node 9 empty empty))))

(visualize 'binary-tree example-bt)
```
Produces:  
![Visualization of the binary tree example-bt](example.png)

----------

## Developer Documentation

```scheme
handler-hash
```

A hash that converts the `tree-type` (_Sym_) to its corresponding handler.
<br><br>

```scheme
(binary->layout tree)
;; binary-tree -> tree-layout
```

Converts a _binary-tree_ to a *tree-layout* for printing.

- `tree` - a binary tree in the form of `(make-node key left right)`
  <br><br>

```scheme
(cons->generic tree)
;; cons-tree -> cons-tree
```

Converts a _cons-tree_ to a generic tree.

- `tree` - a tree in the form of `(cons key (listof children))`
  <br><br>

```scheme
(list->generic tree)
;; list-tree -> cons-tree
```

Converts a _list-tree_ to a generic tree.

- `tree` - a tree in the form of `(list key (listof children))`
  <br><br>

```scheme
(struct->generic tree)
;; struct-tree -> cons-tree
```

Converts a _struct-tree_ to a generic tree.

- `tree` - a tree in the form of `(make-node key (listof children))`
  <br><br>

```scheme
(tree->tree-layout tree)
;; cons-tree -> tree-layout
```

Converts a generic tree to a _tree-layout_ for printing.

- `tree` - a tree in the form of `(cons key (listof children))`
