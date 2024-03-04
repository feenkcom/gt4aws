Class {
	#name : #GtAwsService,
	#superclass : #Object,
	#instVars : [
		'file',
		'rawData',
		'operationExecutor'
	],
	#category : #'Gt4Aws-Importer'
}

{ #category : #accessing }
GtAwsService >> authenticateClient: client [ 
]

{ #category : #accessing }
GtAwsService >> defaultOperationExecutor [
	^ GtAwsCliExecutor
]

{ #category : #accessing }
GtAwsService >> documentation [
	^ self rawData at: 'documentation'
]

{ #category : #accessing }
GtAwsService >> endpointPrefix [
	^ self metadata at: 'endpointPrefix'
]

{ #category : #accessing }
GtAwsService >> file [
	^ file
]

{ #category : #accessing }
GtAwsService >> file: anObject [
	file := anObject
]

{ #category : #accessing }
GtAwsService >> gtRawFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw';
		priority: 5;
		object: [ self rawData ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtAwsService >> initialize [
	super initialize.
	
	self operationExecutor: self defaultOperationExecutor
]

{ #category : #accessing }
GtAwsService >> metadata [
	^ self rawData at: 'metadata'
]

{ #category : #accessing }
GtAwsService >> name [
	^ self metadata at: 'serviceFullName'
]

{ #category : #accessing }
GtAwsService >> operationAt: aString [
	^ self operations
		detect: [ :anOperation | (anOperation at: 'name') = aString ]
		ifNone: [ self error: 'No operation named ' , aString , ' found' ]
]

{ #category : #accessing }
GtAwsService >> operationExecutor [
	^ operationExecutor
]

{ #category : #accessing }
GtAwsService >> operationExecutor: anObject [
	operationExecutor := anObject
]

{ #category : #accessing }
GtAwsService >> operations [
	^ self rawData at: 'operations'
]

{ #category : #accessing }
GtAwsService >> performOperation: anOperation inZone: aZone [
	^ self operationExecutor new
		service: self;
		operation: (self operationAt: anOperation);
		zone: aZone;
		run
]

{ #category : #accessing }
GtAwsService >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtAwsService >> rawData [
	^ rawData
]

{ #category : #accessing }
GtAwsService >> rawData: anObject [
	rawData := anObject
]

{ #category : #accessing }
GtAwsService >> serviceId [
	^ self metadata at: 'serviceId'
]

{ #category : #accessing }
GtAwsService >> shapes [
	^ self rawData at: 'shapes'
]

{ #category : #accessing }
GtAwsService >> version [
	^ self rawData at: 'version'
]
