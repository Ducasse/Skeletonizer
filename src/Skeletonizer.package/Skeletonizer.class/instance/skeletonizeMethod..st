operations
skeletonizeMethod: aSelector
	"nuke mthod body and replace it by ^ self"
	| newTree |
	newTree := (self targetClass >> aSelector) ast
		body: (self class >> #returnSelf) ast body.
	self targetClass compile: newTree formattedCode