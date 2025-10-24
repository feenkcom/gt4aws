Class {
	#name : #GtAwsAutoscalingSetCapacityCommand,
	#superclass : #GtAwsAutoscalingCommand,
	#category : 'Gt4Aws-Commands'
}

{ #category : #accessing }
GtAwsAutoscalingSetCapacityCommand >> desired: anInteger [

	arguments add: (GtAwsCliArgument 
		key: 'desired-capacity' 
		value: anInteger asString)
]

{ #category : #initialization }
GtAwsAutoscalingSetCapacityCommand >> initialize [

	super initialize.
	arguments operation: 'update-auto-scaling-group'.
]

{ #category : #accessing }
GtAwsAutoscalingSetCapacityCommand >> max: anInteger [

	arguments add: (GtAwsCliArgument 
		key: 'max-size' 
		value: anInteger asString)
]

{ #category : #accessing }
GtAwsAutoscalingSetCapacityCommand >> min: anInteger [

	arguments add: (GtAwsCliArgument 
		key: 'min-size' 
		value: anInteger asString)
]

{ #category : #'as yet unclassified' }
GtAwsAutoscalingSetCapacityCommand >> process: aString [

	aString ifNotEmpty: [ self error: 'Unexpected response: ', aString printString ].
]
