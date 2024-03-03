Class {
	#name : #GtAwsWebServiceSignalsLogReader,
	#superclass : #Object,
	#instVars : [
		'signalTypeIndicator'
	],
	#category : #'Gt4Aws-Logging'
}

{ #category : #api }
GtAwsWebServiceSignalsLogReader class >> readFrom: aStream [
	^ self new
		readFrom: aStream
]

{ #category : #api }
GtAwsWebServiceSignalsLogReader class >> readFromFile: aFileReference [
	^ aFileReference readStreamDo: [ :aStream | 
		self new
			readFrom: aStream ]
]

{ #category : #api }
GtAwsWebServiceSignalsLogReader >> createDefaultEventsGrouper [
	^ GtAwsWebServiceCommandEventsGrouper new
]

{ #category : #initialization }
GtAwsWebServiceSignalsLogReader >> initialize [
	super initialize.
	
	signalTypeIndicator := 'AwsEvent'
]

{ #category : #api }
GtAwsWebServiceSignalsLogReader >> processSignals: aCollectionOfSignals [
	| eventsGrouper |
	eventsGrouper := self createDefaultEventsGrouper  .
	eventsGrouper processEventSignalsFor: aCollectionOfSignals.
	^ eventsGrouper
]

{ #category : #api }
GtAwsWebServiceSignalsLogReader >> readFrom: aStream [
	| newSignals typeIndicator |
	newSignals := OrderedCollection new.
	typeIndicator := '| ', self signalTypeIndicator ,' |'.
	
	aStream contents linesDo: [ :aLine |
		(aLine includesSubstring: typeIndicator) ifTrue: [
			| newSignal |
			newSignal := self readSignalFromLine: aLine.
			newSignals add: newSignal ] ].
	
	^ self processSignals: newSignals
]

{ #category : #accessing }
GtAwsWebServiceSignalsLogReader >> readSignalFromLine: aLine [
	| timestampString signalClassName parts signalClass signal |
	
	parts := aLine splitOn: ' | '.
	
	timestampString := parts first copyUpTo: Character space.
	signalClassName := (parts first 
		copyFrom: timestampString size + 1 
		to: parts first size) trimBoth.
	
	signalClass := signalClassName asClass.
	signal := signalClass new.
	signal 
		initializeFromTimestamp: timestampString asDateAndTime 
		andData: parts.
	^ signal
]

{ #category : #accessing }
GtAwsWebServiceSignalsLogReader >> signalTypeIndicator [
	^ signalTypeIndicator
]
