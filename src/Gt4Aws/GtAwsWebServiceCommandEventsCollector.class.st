Class {
	#name : #GtAwsWebServiceCommandEventsCollector,
	#superclass : #GtBeaconEventsCollector,
	#category : #Gt4Aws
}

{ #category : #accessing }
GtAwsWebServiceCommandEventsCollector >> createDefaultEventsGrouper [
	^ GtAwsWebServiceCommandEventsGrouper new
]

{ #category : #accessing }
GtAwsWebServiceCommandEventsCollector >> gtViewCommandsFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Commands';
		items: [ eventsGrouper rootEvents ];
		column: 'Timestamp' 
			text: [ :anEvent | anEvent startTimestamp ]
			width: 200;
		column: 'Command' text: [ :anEvent | anEvent commandString]
]

{ #category : #accessing }
GtAwsWebServiceCommandEventsCollector >> relevantSignalType [
	^ GtAwsWebServiceCommandStartSignal, GtAwsWebServiceCommandEndSignal
]
