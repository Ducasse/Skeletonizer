tests
testSkeletonizeClassMethods
	| maker mockClass |
	mockClass := self class environment at: self mockCopyClassName.
	maker := Skeletonizer new
		classSelectors: #(classMethodToSkeletonize);
		inClass: self mockCopyClassName.
	maker installClass.
	maker skeletonize.
	self deny: mockClass classMethodToSkeletonize = 'body to remove'.
	"in fact since a skeletonized method returns self it is better to test that the return object is of the right class"
	self assert: mockClass classMethodToSkeletonize equals: mockClass.
	self assert: mockClass classMethodToKeepAsIs equals: 'body to be kept'