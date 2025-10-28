Class {
	#name : #GtAwsWebServiceCommandEventsGrouper,
	#superclass : #GtBeaconEventsGrouper,
	#category : 'Gt4Aws-Logging'
}

{ #category : #accessing }
GtAwsWebServiceCommandEventsGrouper >> createDefaultEventsGroup [
	^ GtAwsWebServiceCommandEventsGroup new
]
