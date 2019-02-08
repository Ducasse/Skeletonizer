"
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

"
Class {
	#name : #Skeletonizer,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'newClassName',
		'selectors',
		'classSelectors',
		'sourceClassName',
		'targetClassName'
	],
	#category : 'Skeletonizer'
}

{ #category : #'as yet unclassified' }
Skeletonizer class >> createObJVSkeleton [
	"ObjSkeletonMaker createObjVSkeleton"
	
	| maker |
	Obj duplicateClassWithNewName: #ObjVSkeleton.
	maker := Skeletonizer new
		selectors: #(objIVs objIVs: objKeywords objKeywords: objMethodDict objMethodDict: objName objName: objSuperclassId objSuperclassId: objClass objClassId objClassId: allocateAnInstance offsetFromClassOfInstanceVariable: offsetFromObjectOfInstanceVariable: valueOfInstanceVariable: send:withArguments: super:withArguments:from: lookup: bodyOfMethod:);
		targetClass: #ObjVSkeleton.
	maker installClass.
	maker skeletonize.
]

{ #category : #accessing }
Skeletonizer >> classSelectors: aCollection [
	classSelectors := aCollection
]

{ #category : #initialization }
Skeletonizer >> initialize [

	super initialize.
	selectors := OrderedCollection new.
	classSelectors := OrderedCollection new.
]

{ #category : #installation }
Skeletonizer >> installClass [
	self sourceClass duplicateClassWithNewName: self targetClassName

]

{ #category : #private }
Skeletonizer >> returnSelf [
	"I'm a special method whose program nodes are used to hack skeleton. Do not remove me."
	^ self
]

{ #category : #accessing }
Skeletonizer >> selectors: aCollection [
	selectors := aCollection
]

{ #category : #operations }
Skeletonizer >> skeletonize [
	selectors do: [ :each | self skeletonizeMethod: each ].
	classSelectors do: [ :each | self skeletonizeClassMethod: each ].
]

{ #category : #operations }
Skeletonizer >> skeletonizeClassMethod: aSelector [
	"nuke mthod body and replace it by ^ self"
	| newTree |
	newTree := (self targetClass class >> aSelector) ast
		body: (self class >> #returnSelf) ast body.
	self targetClass class compile: newTree formattedCode
]

{ #category : #operations }
Skeletonizer >> skeletonizeMethod: aSelector [
	"nuke mthod body and replace it by ^ self"
	| newTree |
	newTree := (self targetClass >> aSelector) ast
		body: (self class >> #returnSelf) ast body.
	self targetClass compile: newTree formattedCode
]

{ #category : #installation }
Skeletonizer >> sourceClass [

	^ self class environment at: sourceClassName
]

{ #category : #accessing }
Skeletonizer >> sourceClassName: aSymbol [

	sourceClassName := aSymbol
]

{ #category : #installation }
Skeletonizer >> targetClass [

	^ self class environment at: self targetClassName
]

{ #category : #accessing }
Skeletonizer >> targetClassName [
	"if the target class has not been specified then use the source one."
	targetClassName ifNil: [ targetClassName := sourceClassName ].
	^ targetClassName
]

{ #category : #accessing }
Skeletonizer >> targetClassName: aNewClassName [

	targetClassName := aNewClassName
]
