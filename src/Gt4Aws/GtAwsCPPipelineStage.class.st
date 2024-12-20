Class {
	#name : #GtAwsCPPipelineStage,
	#superclass : #GtAwsObject,
	#instVars : [
		'name',
		'actions',
		'pipeline'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStage class >> fromDictionary: aDict [
	^ (super fromDictionary: aDict)
		name: (aDict at: 'name');
		actions: (aDict at: 'actions')
]

{ #category : #accessing }
GtAwsCPPipelineStage >> actions [
	^ actions
]

{ #category : #accessing }
GtAwsCPPipelineStage >> actions: anObject [
	actions := anObject
]

{ #category : #accessing }
GtAwsCPPipelineStage >> name [
	^ name
]

{ #category : #accessing }
GtAwsCPPipelineStage >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAwsCPPipelineStage >> pipeline [
	^ pipeline
]

{ #category : #accessing }
GtAwsCPPipelineStage >> pipeline: anObject [
	pipeline := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStage >> status [
	^ self pipeline statusOf: self name
]