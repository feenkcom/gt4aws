Class {
	#name : #GtAwsWebServiceCommandEvent,
	#superclass : #GtBeaconLogEvent,
	#category : 'Gt4Aws-Logging'
}

{ #category : #accessing }
GtAwsWebServiceCommandEvent class >> eventLabel [
	^ 'AwsService Command'
]

{ #category : #accessing }
GtAwsWebServiceCommandEvent >> commandString [
	^ self eventStartedSignal commandString
]

{ #category : #accessing }
GtAwsWebServiceCommandEvent >> gtViewArgumentsFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Arguments';
		priority: 7;
		object: [ self eventStartedSignal ];
		view: #gtViewArgumentsFor:
]

{ #category : #accessing }
GtAwsWebServiceCommandEvent >> gtViewCommandStringFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Command';
		priority: 5;
		object: [ self eventStartedSignal ];
		view: #gtViewCommandStringFor:
]
