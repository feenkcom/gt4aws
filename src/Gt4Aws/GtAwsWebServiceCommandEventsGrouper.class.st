Class {
	#name : #GtAwsWebServiceCommandEventsGrouper,
	#superclass : #GtBeaconEventsGrouper,
	#category : #Gt4Aws
}

{ #category : #accessing }
GtAwsWebServiceCommandEventsGrouper >> createDefaultEventsGroup [
	^ GtAwsWebServiceCommandEventsGroup new
]
