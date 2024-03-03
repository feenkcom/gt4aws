Class {
	#name : #GtAwsWebServiceCommandEndSignal,
	#superclass : #GtAwsWebServiceCommandSignal,
	#category : #'Gt4Aws-Logging'
}

{ #category : #initialization }
GtAwsWebServiceCommandEndSignal >> initializeFromTimestamp: aDateAndTime andData: dataParts [ 

	self basicTimestamp: aDateAndTime.
	self basicProcessId: dataParts last
]

{ #category : #testing }
GtAwsWebServiceCommandEndSignal >> isEndSignalType [
	^ true
]

{ #category : #accessing }
GtAwsWebServiceCommandEndSignal >> printOneLineContentsOn: stream [
	stream 
		nextPut: $|; space;
		nextPutAll: 'AwsEvent';
		space; nextPut: $|; space;
		nextPutAll: self processId
]
