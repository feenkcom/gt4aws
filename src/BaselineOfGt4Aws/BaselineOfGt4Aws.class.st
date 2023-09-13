Class {
	#name : #BaselineOfGt4Aws,
	#superclass : #BaselineOf,
	#category : #BaselineOfGt4Aws
}

{ #category : #baseline }
BaselineOfGt4Aws >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'Gt4Aws'
		]
]
