I'm a simple class that can nuke method body to generate skeleton for exercise. 
Right now I do not work at the class level.


!! Example of Use

[[[
| maker |
maker := Skeletonizer new
			selectors: #(methodToSkeletonize);
			sourceClassName: #SkeletonMock;
			targetClassName: #SkeletonMockCopy.
maker installClass.
maker skeletonize.
]]]

It does not copy the package.
