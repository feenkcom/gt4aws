Class {
	#name : #GtAwsWebServiceCommandStartSignal,
	#superclass : #GtAwsWebServiceCommandSignal,
	#instVars : [
		'arguments',
		'retryCount',
		'executableName'
	],
	#category : #'Gt4Aws-Logging'
}

{ #category : #accessing }
GtAwsWebServiceCommandStartSignal >> arguments: anArray [ 
	arguments := anArray
]

{ #category : #utils }
GtAwsWebServiceCommandStartSignal >> commandString [
	^ String streamContents: [ :aStream |
		aStream 
			<< executableName.
		arguments ifNotNil: [
			aStream << ' '.
			arguments 
				asStringOn: aStream 
				delimiter: ' ' ] ]
]

{ #category : #accessing }
GtAwsWebServiceCommandStartSignal >> executableName: aString [ 
	executableName := aString
]

{ #category : #'gt - extensions' }
GtAwsWebServiceCommandStartSignal >> gtViewArgumentsFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Arguments';
		object: [ arguments ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
GtAwsWebServiceCommandStartSignal >> gtViewCommandStringFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Command';
		object: [ self commandString ];
		view: #gtStringFor:
]

{ #category : #initialization }
GtAwsWebServiceCommandStartSignal >> initializeFromTimestamp: aDateAndTime andData: dataParts [ 

	self basicTimestamp: aDateAndTime.
	executableName := dataParts third.
	arguments := self class compiler 
		evaluate: dataParts fourth.
	
	self basicProcessId: dataParts fifth
]

{ #category : #testing }
GtAwsWebServiceCommandStartSignal >> isStartSignalType [
	^ true
]

{ #category : #printing }
GtAwsWebServiceCommandStartSignal >> printOneLineContentsOn: stream [
	stream 
		nextPut: $|; space;
		nextPutAll: 'AwsEvent';
		space; nextPut: $|; space;
		nextPutAll: executableName;
		space; nextPut: $|; space;
		nextPutAll: arguments storeString;
		space; nextPut: $|; space;
		nextPutAll: self processId
]

{ #category : #accessing }
GtAwsWebServiceCommandStartSignal >> retryCount: anInteger [
	retryCount := anInteger 
]
