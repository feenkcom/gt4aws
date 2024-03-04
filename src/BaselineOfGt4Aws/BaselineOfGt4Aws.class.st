Class {
	#name : #BaselineOfGt4Aws,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4Aws
}

{ #category : #accessing }
BaselineOfGt4Aws class >> loadLepiter [
	IceRepository registry
		detect: [ :aRepository | aRepository name = 'gt4aws' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties
				addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [ self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfGt4Aws >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Gt4Aws'
		]
]
