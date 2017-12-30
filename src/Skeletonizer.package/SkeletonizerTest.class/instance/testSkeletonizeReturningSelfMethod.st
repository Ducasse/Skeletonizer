tests
testSkeletonizeReturningSelfMethod
	| maker |
	maker := Skeletonizer new
		selectors: #(methodToSkeletonize2);
		inClass: self mockCopyClassName.
	maker installClass.
	maker skeletonize.

	"does not prove anything when the method return self!!! ."
	self
		assert: (self class environment at: self mockCopyClassName) new methodToSkeletonize2 class
		equals: (self class environment at: self mockCopyClassName).
	self
		assert: ((self class environment at: self mockCopyClassName) >> #methodToSkeletonize2) sourceCode
		equals:
			'methodToSkeletonize2
	"comment to keep"

	^ self'