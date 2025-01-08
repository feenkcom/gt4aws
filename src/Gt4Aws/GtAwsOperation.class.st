Class {
	#name : #GtAwsOperation,
	#superclass : #Object,
	#instVars : [
		'rawData',
		'service',
		'input',
		'output'
	],
	#category : #'Gt4Aws-Importer'
}

{ #category : #'as yet unclassified' }
GtAwsOperation >> documentation [
	^ self rawData at: 'documentation'
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> gtDocumentationFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Documentation';
		priority: 5;
		text: [ self documentation ]
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> gtInputFor: aView [
	<gtView>
	self input ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Input';
		priority: 1;
		object: [ self input ];
		view: #gtMembersFor:
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> gtOutputFor: aView [
	<gtView>
	self output ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Output';
		priority: 2;
		object: [ self output ];
		view: #gtMembersFor:
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> gtRawDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw data';
		priority: 10;
		object: [ self rawData ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtAwsOperation >> input [
	^ input
]

{ #category : #accessing }
GtAwsOperation >> input: anObject [
	input := anObject
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> name [
	^ self rawData at: 'name'
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> onRawDataSupplied [
	(self rawData includesKey: 'input')
		ifTrue: [ self input: (self service shapeAt: (self rawData at: 'input' at: 'shape')) ].

	(self rawData includesKey: 'output')
		ifTrue: [ self output: (self service shapeAt: (self rawData at: 'output' at: 'shape')) ]
]

{ #category : #accessing }
GtAwsOperation >> output [
	^ output
]

{ #category : #accessing }
GtAwsOperation >> output: anObject [
	output := anObject
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> performOperationInZone: aZone [
	^ self service operationExecutor new
		service: self service;
		operation: self;
		zone: aZone;
		run
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> performOperationInZone: aZone withArguments: anArgumentsArray [
	^ self service operationExecutor new
		service: self service;
		operation: self;
		argumentsArray: anArgumentsArray;
		zone: aZone;
		run
]

{ #category : #'as yet unclassified' }
GtAwsOperation >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtAwsOperation >> rawData [
	^ rawData
]

{ #category : #accessing }
GtAwsOperation >> rawData: anObject [
	rawData := anObject.
	
	self onRawDataSupplied
]

{ #category : #accessing }
GtAwsOperation >> service [
	^ service
]

{ #category : #accessing }
GtAwsOperation >> service: anObject [
	service := anObject
]
