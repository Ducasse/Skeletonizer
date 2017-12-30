as yet unclassified
createObJVSkeleton
	"ObjSkeletonMaker createObjVSkeleton"
	
	| maker |
	Obj duplicateClassWithNewName: #ObjVSkeleton.
	maker := Skeletonizer new
		selectors: #(objIVs objIVs: objKeywords objKeywords: objMethodDict objMethodDict: objName objName: objSuperclassId objSuperclassId: objClass objClassId objClassId: allocateAnInstance offsetFromClassOfInstanceVariable: offsetFromObjectOfInstanceVariable: valueOfInstanceVariable: send:withArguments: super:withArguments:from: lookup: bodyOfMethod:);
		inClass: #ObjVSkeleton.
	maker installClass.
	maker skeletonize.