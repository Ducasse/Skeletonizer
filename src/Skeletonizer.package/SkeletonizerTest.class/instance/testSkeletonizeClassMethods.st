tests
testSkeletonizeClassMethods
	| maker sourceMockClass |
	maker := Skeletonizer new
		classSelectors: #(classMethodToSkeletonize);
		sourceClassName: #SkeletonMock;
		targetClassName: self targetMockCopyClassName.
	maker installClass.
	sourceMockClass := self class environment at: self targetMockCopyClassName.
	maker skeletonize.
	self deny: sourceMockClass classMethodToSkeletonize = 'body to remove'.
	"in fact since a skeletonized method returns self it is better to test that the return object is of the right class"
	self assert: sourceMockClass classMethodToSkeletonize equals: sourceMockClass.
	self assert: sourceMockClass classMethodToKeepAsIs equals: 'body to be kept'