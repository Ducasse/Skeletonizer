tests
testSkeletonizeReturningSelfMethod
	| maker |
	maker := Skeletonizer new
		selectors: #(methodToSkeletonize2);
		sourceClassName: #SkeletonMock;
		targetClassName: self targetMockCopyClassName.
	maker installClass.
	maker skeletonize.

	"does not prove anything when the method return self!!! ."
	self
		assert: (self class environment at: self targetMockCopyClassName) new methodToSkeletonize2 class
		equals: (self class environment at: self targetMockCopyClassName).
	self
		assert: ((self class environment at: self targetMockCopyClassName) >> #methodToSkeletonize2) sourceCode
		equals:
			'methodToSkeletonize2
	"comment to keep"

	^ self'