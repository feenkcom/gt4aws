Extension { #name : #ZnUrl }

{ #category : #'*Gt4Aws' }
ZnUrl >> parent [

	^ self hasPath ifTrue: 
		[ | parentSegments |
		parentSegments := segments allButLast.
		self isDirectoryPath ifTrue: [ parentSegments removeLast ].
		self copy segments: parentSegments ]
	ifFalse: [ self copy ]
]
