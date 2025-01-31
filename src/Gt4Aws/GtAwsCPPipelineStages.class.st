Class {
	#name : #GtAwsCPPipelineStages,
	#superclass : #GtAwsGroup,
	#instVars : [
		'roleArn',
		'client',
		'pipeline'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCPPipelineStages class >> fromDictionary: aDict [
	^ (self
		withAll: ((aDict at: 'stages')
				collect: [ :anObject | GtAwsCPPipelineStage fromDictionary: anObject ]))
		roleArn: (aDict at: 'roleArn')
]

{ #category : #accessing }
GtAwsCPPipelineStages >> client [
	^ client
]

{ #category : #accessing }
GtAwsCPPipelineStages >> client: anObject [
	client := anObject.

	self items do: [ :aStage | aStage client: anObject ]
]

{ #category : #accessing }
GtAwsCPPipelineStages >> pipeline [
	^ pipeline
]

{ #category : #accessing }
GtAwsCPPipelineStages >> pipeline: anObject [
	pipeline := anObject.

	self items do: [ :aStage | aStage pipeline: anObject ]
]

{ #category : #accessing }
GtAwsCPPipelineStages >> roleArn [
	^ roleArn
]

{ #category : #accessing }
GtAwsCPPipelineStages >> roleArn: anObject [
	roleArn := anObject
]
