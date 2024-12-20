Class {
	#name : #GtAwsCPPipelineStageStatus,
	#superclass : #GtAwsObject,
	#instVars : [
		'name',
		'latestExecution'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStageStatus class >> fromDictionary: aDict [
	^ (super fromDictionary: aDict)
		name: (aDict at: 'stageName');
		latestExecution: (aDict at: 'latestExecution' ifAbsent: [ nil ])
]

{ #category : #accessing }
GtAwsCPPipelineStageStatus >> latestExecution [
	^ latestExecution
]

{ #category : #accessing }
GtAwsCPPipelineStageStatus >> latestExecution: anObject [
	latestExecution := anObject
]

{ #category : #accessing }
GtAwsCPPipelineStageStatus >> name [
	^ name
]

{ #category : #accessing }
GtAwsCPPipelineStageStatus >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStageStatus >> stateColor [
	self latestExecution ifNil: [ ^ BrGlamorousColors disabledButtonTextColor ].
	^ (self latestExecution at: 'status') = 'Succeeded'
		ifTrue: [ BrGlamorousColors successBorderColor ]
		ifFalse: [ BrGlamorousColors errorBorderColor ]
]

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStageStatus >> stateString [
	self latestExecution ifNil: [ ^ 'Didn’t run' ].
	^ self latestExecution at: 'status'
]

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStageStatus >> stateText [
	^ self stateString asRopedText foreground: self stateColor
]
