Class {
	#name : #GtAwsCPPipeline,
	#superclass : #GtAwsObject,
	#instVars : [
		'name',
		'version',
		'created',
		'updated',
		'stages',
		'status'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsCPPipeline class >> fromDictionary: aDict [
	^ (super fromDictionary: aDict)
		name: (aDict at: 'name');
		version: (aDict at: 'version');
		created: (DateAndTime fromString: (aDict at: 'created'));
		updated: (DateAndTime fromString: (aDict at: 'updated'))
]

{ #category : #accessing }
GtAwsCPPipeline >> created [
	^ created
]

{ #category : #accessing }
GtAwsCPPipeline >> created: anObject [
	created := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCPPipeline >> gtPipelineFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pipeline';
		priority: 1;
		items: [ self stages ];
		column: 'Name' text: #name;
		column: 'Actions'
			text: [ :aStage | ', ' join: (aStage actions collect: [ :anAction | anAction at: 'name' ]) ];
		column: 'Status' text: [ :aStage | aStage status stateText ]
]

{ #category : #accessing }
GtAwsCPPipeline >> name [
	^ name
]

{ #category : #accessing }
GtAwsCPPipeline >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCPPipeline >> refreshStages [
	stages := self client codePipelineGetPipeline: self name.
	stages pipeline: self.
	^ stages
]

{ #category : #'as yet unclassified' }
GtAwsCPPipeline >> refreshStatus [
	^ status := self client codePipelineGetPipelineState: self name
]

{ #category : #'as yet unclassified' }
GtAwsCPPipeline >> stages [
	^ stages ifNil: [ self refreshStages ]
]

{ #category : #'as yet unclassified' }
GtAwsCPPipeline >> status [
	^ status ifNil: [ self refreshStatus ]
]

{ #category : #'as yet unclassified' }
GtAwsCPPipeline >> statusOf: aName [
	^ self status statusOf: aName
]

{ #category : #accessing }
GtAwsCPPipeline >> updated [
	^ updated
]

{ #category : #accessing }
GtAwsCPPipeline >> updated: anObject [
	updated := anObject
]

{ #category : #accessing }
GtAwsCPPipeline >> version [
	^ version
]

{ #category : #accessing }
GtAwsCPPipeline >> version: anObject [
	version := anObject
]
