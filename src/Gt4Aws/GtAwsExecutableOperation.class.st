Class {
	#name : #GtAwsExecutableOperation,
	#superclass : #Object,
	#instVars : [
		'operation',
		'profile',
		'zone',
		'argumentsArray'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsExecutableOperation >> argumentsArray [
	^ argumentsArray
]

{ #category : #accessing }
GtAwsExecutableOperation >> argumentsArray: anObject [
	argumentsArray := anObject
]

{ #category : #accessing }
GtAwsExecutableOperation >> operation [
	^ operation
]

{ #category : #accessing }
GtAwsExecutableOperation >> operation: anObject [
	operation := anObject
]

{ #category : #accessing }
GtAwsExecutableOperation >> profile [
	^ profile
]

{ #category : #accessing }
GtAwsExecutableOperation >> profile: anObject [
	profile := anObject
]

{ #category : #'as yet unclassified' }
GtAwsExecutableOperation >> toArguments [
	| mangledOperationName |
	mangledOperationName := '-'
			join: (self operation name splitCamelCase collect: #asLowercase).
	^ Array
		streamContents: [ :stream | 
			stream
				nextPut: self operation service endpointPrefix;
				nextPut: mangledOperationName.
			self profile
				ifNotNil: [ :aProfile | 
					stream
						nextPut: '--profile';
						nextPut: aProfile ].
			self zone
				ifNotNil: [ :aZone | 
					stream
						nextPut: '--region';
						nextPut: aZone ].
			stream nextPutAll: (self argumentsArray ifNil: [ #() ] ifNotNil: #asCli) ]
]

{ #category : #accessing }
GtAwsExecutableOperation >> zone [
	^ zone
]

{ #category : #accessing }
GtAwsExecutableOperation >> zone: anObject [
	zone := anObject
]
