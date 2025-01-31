Class {
	#name : #GtAwsResponse,
	#superclass : #Object,
	#instVars : [
		'content',
		'operation'
	],
	#category : #'Gt4Aws-Client'
}

{ #category : #accessing }
GtAwsResponse >> content [
	^ content
]

{ #category : #accessing }
GtAwsResponse >> content: anObject [
	content := anObject
]

{ #category : #accessing }
GtAwsResponse >> operation [
	^ operation
]

{ #category : #accessing }
GtAwsResponse >> operation: anObject [
	operation := anObject
]
