initialization
removeMock
	(self class environment at: self targetMockCopyClassName ifAbsent: [nil]) 
		ifNotNil: [ :c | c removeFromSystem].
	