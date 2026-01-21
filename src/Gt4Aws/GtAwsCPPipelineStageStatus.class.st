Class {
	#name : #GtAwsCPPipelineStageStatus,
	#superclass : #GtAwsObject,
	#instVars : [
		'name',
		'latestExecution'
	],
	#category : 'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStageStatus class >> fromDictionary: aDict [
	^ (super fromDictionary: aDict)
		name: (aDict at: 'stageName');
		latestExecution: (aDict at: 'latestExecution' ifAbsent: [ nil ])
]

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStageStatus >> gtStatesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'States';
		priority: 1;
		items: [ self jsonObject at: 'actionStates' ];
		column: 'Name' text: [ :aState | aState at: 'actionName' ];
		column: 'Status'
			text: [ :aState | aState at: 'latestExecution' at: 'status' ];
		column: 'Updated'
			text: [ :aState | aState at: 'latestExecution' at: 'lastStatusChange' ];
		column: 'Management console'
			icon: [ :aState | 
				((aState at: 'latestExecution') includesKey: 'externalExecutionUrl')
					ifTrue: [ BrButton new
							aptitude: BrGlamorousButtonWithIconAptitude new;
							label: 'Go to management console';
							icon: BrGlamorousVectorIcons window;
							action: [ WebBrowser openOn: (aState at: 'latestExecution' at: 'externalExecutionUrl') ] ]
					ifFalse: [ BlElement new size: 0 @ 0 ] ]
]

{ #category : #accessing }
GtAwsCPPipelineStageStatus >> latestExecution [
	^ latestExecution
]

{ #category : #accessing }
GtAwsCPPipelineStageStatus >> latestExecution: anObject [
	latestExecution := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCPPipelineStageStatus >> managementConsoleUrl [
	^ (self jsonObject at: 'actionStates') first at: 'externalExecutionUrl'
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
