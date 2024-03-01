Class {
	#name : #GtAwsLambda,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsLambda >> client [
	^ client
]

{ #category : #accessing }
GtAwsLambda >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsLambda >> functions [
	^ self client lambdaListFunctions
]

{ #category : #accessing }
GtAwsLambda >> gtDisplayOn: stream [
	stream nextPutAll: 'AWS Lambda'
]

{ #category : #accessing }
GtAwsLambda >> gtLambdasOn: aView [
	<gtView>
	^ aView forward
		title: 'Functions';
		priority: 1;
		object: [ self functions ];
		view: #gtFunctionsFor:
]
