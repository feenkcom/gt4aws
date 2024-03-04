Class {
	#name : #GtAwsOperationExecutor,
	#superclass : #Object,
	#instVars : [
		'service',
		'operation',
		'zone'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsOperationExecutor >> deserialize: anObject [
	^ GtAwsOperationResult new
		result: anObject;
		resultType: (self operation at: 'output' at: 'shape');
		types: (self service at: 'shapes')
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

{ #category : #accessing }
GtAwsOperationExecutor >> run [
	^ self deserialize: self execute
]

{ #category : #accessing }
GtAwsOperationExecutor >> service [
	^ service
]

{ #category : #accessing }
GtAwsOperationExecutor >> service: anObject [
	service := anObject
]

{ #category : #accessing }
GtAwsOperationExecutor >> zone [
	^ zone
]

{ #category : #accessing }
GtAwsOperationExecutor >> zone: anObject [
	zone := anObject
]
