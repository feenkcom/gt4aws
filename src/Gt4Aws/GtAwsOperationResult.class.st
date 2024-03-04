Class {
	#name : #GtAwsOperationResult,
	#superclass : #Object,
	#instVars : [
		'result',
		'resultType',
		'types'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsOperationResult >> result [
	^ result
]

{ #category : #accessing }
GtAwsOperationResult >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GtAwsOperationResult >> resultType [
	^ resultType
]

{ #category : #accessing }
GtAwsOperationResult >> resultType: anObject [
	resultType := anObject
]

{ #category : #accessing }
GtAwsOperationResult >> types [
	^ types
]

{ #category : #accessing }
GtAwsOperationResult >> types: anObject [
	types := anObject
]
