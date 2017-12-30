operations
skeletonizeMethod: aSelector
	"nuke mthod body and replace it by ^ self"
	| newTree |
	newTree := (self newClass >> aSelector) ast
		body: (self class >> #returnSelf) ast body.
	self newClass compile: newTree formattedCode