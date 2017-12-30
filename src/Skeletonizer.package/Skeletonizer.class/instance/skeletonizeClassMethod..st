operations
skeletonizeClassMethod: aSelector
	"nuke mthod body and replace it by ^ self"
	| newTree |
	newTree := (self newClass class >> aSelector) ast
		body: (self class >> #returnSelf) ast body.
	self newClass class compile: newTree formattedCode