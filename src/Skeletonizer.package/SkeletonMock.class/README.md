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