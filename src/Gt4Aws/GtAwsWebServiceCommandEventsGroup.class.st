Class {
	#name : #GtAwsWebServiceCommandEventsGroup,
	#superclass : #GtBeaconLogEventsGroup,
	#category : #'Gt4Aws-Logging'
}

{ #category : #accessing }
GtAwsWebServiceCommandEventsGroup >> gtViewCommandsFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Commands';
		items: [ self ];
		priority: 30;
		column: 'Timestamp' 
			text: [ :anEvent | anEvent startTimestamp ]
			width: 200;
		column: 'Command' text: [ :anEvent | anEvent commandString]
]
