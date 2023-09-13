Class {
	#name : #GtAwsWebServiceCommandSignal,
	#superclass : #BeaconSignal,
	#category : #Gt4Aws
}

{ #category : #accessing }
GtAwsWebServiceCommandSignal class >> eventType [
	^ GtAwsWebServiceCommandEvent
]

{ #category : #testing }
GtAwsWebServiceCommandSignal >> isEndSignalType [
	^ false
]

{ #category : #testing }
GtAwsWebServiceCommandSignal >> isStartSignalType [
	^ false
]
