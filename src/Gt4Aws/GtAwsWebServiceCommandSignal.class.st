Class {
	#name : #GtAwsWebServiceCommandSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'arguments',
		'retryCount',
		'executableName'
	],
	#category : #'Gt4Aws-Logging'
}

{ #category : #accessing }
GtAwsWebServiceCommandSignal class >> eventType [
	^ GtAwsWebServiceCommandEvent
]

{ #category : #accessing }
GtAwsWebServiceCommandSignal >> arguments: anArray [ 
	arguments := anArray
]

{ #category : #utils }
GtAwsWebServiceCommandSignal >> commandString [
	^ String streamContents: [ :aStream |
		aStream 
			<< executableName.
		arguments ifNotNil: [
			arguments class == GtAwsCliArguments ifTrue:
				[ aStream
					<< ' ';
					<< arguments endpointPrefix;
					<< ' ';
					<< arguments operation ].
			arguments do: [ :arg |
				aStream 
					<< ' ';
					<< arg asString ] ] ]
]

{ #category : #accessing }
GtAwsWebServiceCommandSignal >> executableName: aString [ 
	executableName := aString
]

{ #category : #'gt - extensions' }
GtAwsWebServiceCommandSignal >> gtViewArgumentsFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Arguments';
		object: [ arguments ];
		view: #gtItemsFor:
]

{ #category : #'gt - extensions' }
GtAwsWebServiceCommandSignal >> gtViewCommandStringFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Command';
		object: [ self commandString ];
		view: #gtStringFor:
]

{ #category : #initialization }
GtAwsWebServiceCommandSignal >> initializeFromTimestamp: aDateAndTime andData: dataParts [ 

	self basicTimestamp: aDateAndTime.
	executableName := dataParts third.
	arguments := self class compiler 
		evaluate: dataParts fourth.
	
	self basicProcessId: dataParts fifth
]

{ #category : #testing }
GtAwsWebServiceCommandSignal >> isEndSignalType [
	^ false
]

{ #category : #testing }
GtAwsWebServiceCommandSignal >> isStartSignalType [
	^ false
]

{ #category : #printing }
GtAwsWebServiceCommandSignal >> printOneLineContentsOn: stream [
	stream 
		<< ' | ';
		nextPutAll: 'AwsEvent';
		<< ' | ';
		nextPutAll: executableName asString;
		<< ' | ';
		nextPutAll: arguments storeString;
		<< ' | ';
		nextPutAll: self processId asString
]

{ #category : #accessing }
GtAwsWebServiceCommandSignal >> retryCount: anInteger [
	retryCount := anInteger 
]

{ #category : #accessing }
GtAwsWebServiceCommandSignal >> signalTypeLabel [

	^ 'Aws Command Signal'
]
