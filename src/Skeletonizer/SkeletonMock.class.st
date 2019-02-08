"
(ObjSkeletonMock >> #methodToKeepAsIs) sourceCode
	

(ObjSkeletonMock >> #methodToKeepAsIs) ast
	
(ObjSkeletonMock >> #returnSelf) ast
	
| newTree |	
newTree := 
	(ObjSkeletonMock >> #methodToSkeletonize2) ast body: 
		(ObjSkeletonMock >> #returnSelf) ast body.
newTree formattedCode.
ObjSkeletonMock compile: newTree formattedCode classified: #foo


| newTree |	
newTree := 
	(ObjSkeletonMock >> #methodToSkeletonize2) ast body: 
		(ObjSkeletonMock >> #returnSelf) ast body.
newTree formattedCode.
ObjSkeletonMock compile: newTree formattedCode
"
Class {
	#name : #SkeletonMock,
	#superclass : #Object,
	#category : 'Skeletonizer'
}

{ #category : #methods }
SkeletonMock class >> classMethodToKeepAsIs [
	"comment to keep"

	^ 'body to be kept'
]

{ #category : #methods }
SkeletonMock class >> classMethodToSkeletonize [
	"comment to keep"

	^ 'body to be removed'
]

{ #category : #methods }
SkeletonMock >> methodToKeepAsIs [
	"comment to keep"
	
	^ 'body to be kept'.

]

{ #category : #methods }
SkeletonMock >> methodToSkeletonize [
	"comment to keep"
	
	^ 'body to be removed'
	
]

{ #category : #methods }
SkeletonMock >> methodToSkeletonize2 [
	"comment to keep"
	
	33 + 66.
	^ self
]
