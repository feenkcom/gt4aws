Class {
	#name : #GtAwsOperationExecutor,
	#superclass : #Object,
	#instVars : [
		'operation',
		'zone',
		'argumentsArray',
		'profile'
	],
	#category : 'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsOperationExecutor >> argumentsArray [
	^ argumentsArray
]

{ #category : #accessing }
GtAwsOperationExecutor >> argumentsArray: anObject [
	argumentsArray := anObject
]

{ #category : #accessing }
GtAwsOperationExecutor >> deserialize: anObject [
	^ GtAwsOperationResult new
		key: 'Response';
		result: (STONJSON fromString: anObject);
		resultType: (self operation output);
		types: self operation service shapes
]

{ #category : #accessing }
GtAwsOperationExecutor >> execute [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsOperationExecutor >> operation [
	^ operation
]

{ #category : #accessing }
GtAwsOperationExecutor >> operation: anObject [
	operation := anObject
]

{ #category : #'as yet unclassified' }
GtAwsOperationExecutor >> prepareOperation [
	^ GtAwsExecutableOperation new
		operation: self operation;
		profile: self profile;
		zone: self zone;
		argumentsArray: self argumentsArray
]

{ #category : #accessing }
GtAwsOperationExecutor >> profile [
	^ profile
]

{ #category : #accessing }
GtAwsOperationExecutor >> profile: anObject [
	profile := anObject
]

{ #category : #accessing }
GtAwsOperationExecutor >> run [
	^ self deserialize: self execute
]

{ #category : #accessing }
GtAwsOperationExecutor >> zone [
	^ zone
]

{ #category : #accessing }
GtAwsOperationExecutor >> zone: anObject [
	zone := anObject
]
