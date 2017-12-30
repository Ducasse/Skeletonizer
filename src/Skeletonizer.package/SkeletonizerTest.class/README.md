So far does not skeletonize class methods since we can only pass a class name.

!!! Example of use is:

[[[
| maker |
maker := ObjSkeletonMaker new
		selectors: #(methodToSkeletonize);
		inClass: self mockCopyClassName.
maker installClass.
maker skeletonize.
]]]