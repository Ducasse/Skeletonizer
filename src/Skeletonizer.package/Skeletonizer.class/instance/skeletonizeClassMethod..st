operations
skeletonizeClassMethod: aSelector
	"nuke mthod body and replace it by ^ self"
	| newTree |
	newTree := (self targetClass class >> aSelector) ast
		body: (self class >> #returnSelf) ast body.
	self targetClass class compile: newTree formattedCode