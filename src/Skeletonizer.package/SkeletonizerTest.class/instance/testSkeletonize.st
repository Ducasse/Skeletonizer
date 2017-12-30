tests
testSkeletonize
	| maker mockClass |
	mockClass := self class environment at: self mockCopyClassName.
	maker := Skeletonizer new
		selectors: #(methodToSkeletonize);
		inClass: self mockCopyClassName.
	maker installClass.
	maker skeletonize.
	self deny: mockClass new methodToSkeletonize = 'body to remove'.
	"in fact since a skeletonized method returns self it is better to test that the return object is of the right class"
	self assert: mockClass new methodToSkeletonize class equals: mockClass.
	self assert: mockClass new methodToKeepAsIs equals: 'body to be kept'