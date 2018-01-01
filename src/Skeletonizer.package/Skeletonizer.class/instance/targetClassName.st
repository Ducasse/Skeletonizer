accessing
targetClassName
	"if the target class has not been specified then use the source one."
	targetClassName ifNil: [ targetClassName := sourceClassName ].
	^ targetClassName