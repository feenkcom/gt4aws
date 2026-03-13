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
GtAwsWebServiceCommandSignal >> arguments [
	^arguments
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
GtAwsWebServiceCommandSignal >> executableName [
	^executableName
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

{ #category : #accessing }
GtAwsWebServiceCommandSignal >> matchingSignalFrom: candidateEvents [
	"Answer the receiver's match from the supplied signals.
	The collection is expected to typically be small and contain the match.
	The default is to match on processId, or if there is only a single candidate, accept that."

	candidateEvents 
		detect:  [ :each | each eventStartedSignal processId = self processId ]
		ifFound: [ :event | ^ event].
	candidateEvents size = 1 ifTrue:
			[ ^ candidateEvents first ].
	^ nil
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
GtAwsWebServiceCommandSignal >> retryCount [
	^retryCount
]

{ #category : #accessing }
GtAwsWebServiceCommandSignal >> retryCount: anInteger [
	retryCount := anInteger 
]

{ #category : #accessing }
GtAwsWebServiceCommandSignal >> signalTypeLabel [

	^ 'Aws Command Signal'
]
