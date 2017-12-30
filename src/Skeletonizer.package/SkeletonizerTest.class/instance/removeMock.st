initialization
removeMock
	(self class environment at: self mockCopyClassName ifAbsent: [nil]) 
		ifNotNil: [ :c | c removeFromSystem].
	