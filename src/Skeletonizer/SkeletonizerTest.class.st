"
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
"
Class {
	#name : #SkeletonizerTest,
	#superclass : #TestCase,
	#type : #variable,
	#category : 'Skeletonizer'
}

{ #category : #initialization }
SkeletonizerTest >> removeMock [
	(self class environment at: self targetMockCopyClassName ifAbsent: [nil]) 
		ifNotNil: [ :c | c removeFromSystem].
	
]

{ #category : #initialization }
SkeletonizerTest >> setUp [
	self removeMock.
	
]

{ #category : #initialization }
SkeletonizerTest >> targetMockCopyClassName [
	^ #SkeletonMockCopy
]

{ #category : #initialization }
SkeletonizerTest >> tearDown [
		self removeMock.
]

{ #category : #tests }
SkeletonizerTest >> testSkeletonize [
	| maker mockClass |
	maker := Skeletonizer new
		selectors: #(methodToSkeletonize);
		sourceClassName: #SkeletonMock;
		targetClassName: self targetMockCopyClassName.
	maker installClass.
	maker skeletonize.
	mockClass := self class environment at: self targetMockCopyClassName.
	self deny: mockClass new methodToSkeletonize = 'body to remove'.
	"in fact since a skeletonized method returns self it is better to test that the return object is of the right class"
	self assert: mockClass new methodToSkeletonize class equals: mockClass.
	self assert: mockClass new methodToKeepAsIs equals: 'body to be kept'
]

{ #category : #tests }
SkeletonizerTest >> testSkeletonizeClassMethods [
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
]

{ #category : #tests }
SkeletonizerTest >> testSkeletonizeReturningSelfMethod [
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
]
