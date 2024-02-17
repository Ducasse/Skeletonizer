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
	#category : #Skeletonizer
}

{ #category : #initialization }
SkeletonizerTest >> removeMock [
	(self class environment at: self targetMockCopyClassName ifAbsent: [nil]) 
		ifNotNil: [ :c | c removeFromSystem].
	
]

{ #category : #initialization }
SkeletonizerTest >> setUp [
	super setUp.
	self removeMock
	
]

{ #category : #initialization }
SkeletonizerTest >> targetMockCopyClassName [
	^ #SkeletonMockCopy
]

{ #category : #initialization }
SkeletonizerTest >> tearDown [
		self removeMock.
		super tearDown
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
	self 
		assert: (mockClass >> #methodToSkeletonize) ast body sourceCode 
		equals: '^ self shouldBeImplemented'.
		
	self 
		assert: (mockClass >> #methodToKeepAsIs) ast body sourceCode
		equals:  '^ ''body to be kept''.'
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
	
	self 
		assert: (sourceMockClass class >> #classMethodToSkeletonize) ast body sourceCode 
		equals: '^ self shouldBeImplemented'.
		
	self 
		assert: (sourceMockClass class  >> #classMethodToKeepAsIs) ast body sourceCode
		equals:  '^ ''body to be kept'''
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

	self
		assert: ((self class environment at: self targetMockCopyClassName) >> #methodToSkeletonize2) sourceCode
		equals:
			'methodToSkeletonize2
	"comment to keep"

	^ self shouldBeImplemented'
]
