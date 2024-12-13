Class {
	#name : #GtAwsService,
	#superclass : #Object,
	#instVars : [
		'file',
		'rawData',
		'operationExecutor',
		'operations',
		'shapes',
		'profile',
		'zone'
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

{ #category : #actions }
GtAwsService >> getCommandFinalStatus: commandId instanceId: instanceId wait: maxExecutionTimeDuration inZone: aZone [
	"Wait for the specified command to complete and return the status"
	| status startTime waitDuration |

	"Wait 1/10th of the max execution time, but never less than 15 seconds
	(since the minimum execution time is a few seconds)"
	waitDuration := (maxExecutionTimeDuration asSeconds / 10 max: 15) seconds.
	startTime := DateAndTime now.
	[ status := self performOperation: 'GetCommandInvocation' 
		inZone: aZone
		withArguments: {
			'--command-id'.
			commandId.
			'--instance-id'.
			instanceId. }.
	(status at: 'Status') = 'InProgress' and:
		[ (DateAndTime now - startTime) < maxExecutionTimeDuration ] ] whileTrue:
		[ waitDuration wait ].
	(status at: 'Status') = 'InProgress' ifTrue:
		[ self error: 'Remote execution exceeded allowed time' ].
	^ status
]

{ #category : #actions }
GtAwsService >> getCommandStatus: commandId instanceId: instanceId inZone: aZone [
	"Wait for the specified command to complete and return the status"

	^ self performOperation: 'GetCommandInvocation' 
		inZone: aZone
		withArguments: {
			'--command-id'.
			commandId.
			'--instance-id'.
			instanceId. }.
]

{ #category : #'as yet unclassified' }
GtAwsService >> gtDocumentationFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Documentation';
		priority: 8;
		text: [ self documentation ]
]

{ #category : #'as yet unclassified' }
GtAwsService >> gtMetaDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Meta data';
		priority: 5;
		object: [ self metadata ];
		view: #gtItemsFor:
]

{ #category : #'as yet unclassified' }
GtAwsService >> gtOperationsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Operations';
		priority: 1;
		items: [ self operations values ];
		column: 'Name' text: #name;
		column: 'Documentation' text: #documentation
]

{ #category : #accessing }
GtAwsService >> gtRawDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw data';
		priority: 10;
		object: [ self rawData ];
		view: #gtLiveFor:
]

{ #category : #'as yet unclassified' }
GtAwsService >> gtShapesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Shapes';
		priority: 2;
		items: [ self shapes values ];
		column: 'Name' text: #name;
		column: 'Documentation' text: #documentation
]

{ #category : #accessing }
GtAwsService >> initialize [
	super initialize.

	self shapes: Dictionary new.
	self operations: Dictionary new.

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
GtAwsService >> onRawDataSupplied [
	(self rawData at: 'shapes') associations
		do: [ :aPair | 
			(self shapeAt: aPair key)
				service: self;
				rawData: aPair value ].

	self
		operations: ((self rawData at: 'operations') associations
				collect: [ :aPair | 
					aPair key
						-> (GtAwsOperation new
								service: self;
								rawData: aPair value) ]) asDictionary
]

{ #category : #accessing }
GtAwsService >> operationAt: aString [
	^ self operations at: aString
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
	^ operations
]

{ #category : #accessing }
GtAwsService >> operations: anObject [
	operations := anObject
]

{ #category : #accessing }
GtAwsService >> performOperation: anOperation [
	^ self operationExecutor new
		operation: (self operationAt: anOperation);
		profile: self profile;
		zone: self zone;
		run
]

{ #category : #accessing }
GtAwsService >> performOperation: anOperation inZone: aZone [
	^ self operationExecutor new
		operation: (self operationAt: anOperation);
		zone: aZone;
		profile: self profile;
		run
]

{ #category : #accessing }
GtAwsService >> performOperation: anOperation inZone: aZone withArguments: anArray [
	^ self operationExecutor new
		operation: (self operationAt: anOperation);
		argumentsArray: anArray;
		profile: self profile;
		zone: aZone;
		run
]

{ #category : #accessing }
GtAwsService >> performOperation: anOperation withArguments: anArray [
	^ self operationExecutor new
		operation: (self operationAt: anOperation);
		argumentsArray: anArray;
		profile: self profile;
		zone: self zone;
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
GtAwsService >> profile [
	^ profile
]

{ #category : #accessing }
GtAwsService >> profile: anObject [
	profile := anObject
]

{ #category : #accessing }
GtAwsService >> rawData [
	^ rawData
]

{ #category : #accessing }
GtAwsService >> rawData: anObject [
	rawData := anObject.
	
	self onRawDataSupplied
]

{ #category : #accessing }
GtAwsService >> serviceId [
	^ self metadata at: 'serviceId'
]

{ #category : #'as yet unclassified' }
GtAwsService >> shapeAt: aString [
	^ self shapes at: aString ifAbsentPut: [ GtAwsShape new name: aString ]
]

{ #category : #accessing }
GtAwsService >> shapes [
	^ shapes
]

{ #category : #accessing }
GtAwsService >> shapes: anObject [
	shapes := anObject
]

{ #category : #accessing }
GtAwsService >> version [
	^ self rawData at: 'version'
]

{ #category : #accessing }
GtAwsService >> zone [
	^ zone
]

{ #category : #accessing }
GtAwsService >> zone: anObject [
	zone := anObject
]
