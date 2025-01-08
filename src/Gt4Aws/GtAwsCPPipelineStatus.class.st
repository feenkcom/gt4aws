Class {
	#name : #GtAwsCPPipelineStatus,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStatus >> statusOf: aName [
	^ self items detect: [ :anItem | anItem name = aName ]
]
