Class {
	#name : #GtAwsService,
	#superclass : #Object,
	#instVars : [
		'file',
		'rawData'
	],
	#category : #'Gt4Aws-Importer'
}

{ #category : #accessing }
GtAwsService >> authenticateClient: client [ 
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
GtAwsService >> operationToArguments: anOperation [
	| mangledOperationName |
	mangledOperationName := '-'
			join: ((anOperation at: 'name') splitCamelCase collect: #asLowercase).
	^ {self endpointPrefix.
		mangledOperationName}
]

{ #category : #accessing }
GtAwsService >> operations [
	^ self rawData at: 'operations'
]

{ #category : #accessing }
GtAwsService >> performOperation: anOperation inZone: aZone [
	| operation |
	operation := self operationAt: anOperation.

	^ GtAwsAmazonWebServices default
		runArguments: (self operationToArguments: operation)
		returnBlock: #stdout
		retryCount: 3
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
GtAwsService >> version [
	^ self rawData at: 'version'
]
