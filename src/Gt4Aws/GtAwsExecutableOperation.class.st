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
	self argumentsArray ifNil: [ self argumentsArray: GtAwsCliArguments new ].

	self argumentsArray
		operation: ('-' join: (self operation name splitCamelCase collect: #asLowercase)).
	self argumentsArray endpointPrefix: self operation service endpointPrefix.

	self profile
		ifNotNil: [ :aProfile | 
			self argumentsArray
				addFirst: (GtAwsCliArgument new
						key: 'profile';
						value: aProfile) ].
	self zone
		ifNotNil: [ :aZone | 
			self argumentsArray
				addFirst: (GtAwsCliArgument new
						key: 'region';
						value: aZone) ].
	
	^ self argumentsArray
]

{ #category : #accessing }
GtAwsExecutableOperation >> zone [
	^ zone
]

{ #category : #accessing }
GtAwsExecutableOperation >> zone: anObject [
	zone := anObject
]
