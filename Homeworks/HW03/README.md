# HW03: Datalog

Starting from the base predicates

```prolog
parentOf(Parent,Child).
male().
female().
```
with the obvious intuitive meanings.

Define rules defining the following family relations:
```prolog
grandMother(GM, GC).   % GM is the grandmother of GC
greatGrandParent(GGP, GGC).  % GGP is the great-grandparent of GGC
brotherOf(B, S). % B is the brother of S
secondCousin(A, B). % A and B share a great-grandparent but no closer ancestor
```

[Diagram of first cousin and second cousin](https://en.wikipedia.org/wiki/Cousin#/media/File:CousinTree.svg)