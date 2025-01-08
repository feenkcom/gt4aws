Class {
	#name : #GtAwsOperationResult,
	#superclass : #Object,
	#instVars : [
		'result',
		'resultType',
		'types',
		'key',
		'documentation'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsOperationResult >> at: keyString [

	^ self result at: keyString
]

{ #category : #accessing }
GtAwsOperationResult >> atPath: aCollection [

	^ aCollection
		  inject: self
		  into: [ :aResult :anIndex | aResult at: anIndex ]
]

{ #category : #accessing }
GtAwsOperationResult >> documentation [
	^ documentation
]

{ #category : #accessing }
GtAwsOperationResult >> documentation: anObject [
	documentation := anObject
]

{ #category : #accessing }
GtAwsOperationResult >> gtDescriptionFor: aView [
	<gtView>
	^ aView forward
		title: 'Description';
		priority: 10;
		object: [ self resultType ];
		view: #gtMembersFor:
]

{ #category : #accessing }
GtAwsOperationResult >> gtResultFor: aView [
	<gtView>
	^ aView forward
		title: 'Result';
		priority: 5;
		object: [ self result ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtAwsOperationResult >> initialize [
	super initialize.
	
	key := ''.
	documentation := ''
]

{ #category : #accessing }
GtAwsOperationResult >> key [
	^ key
]

{ #category : #accessing }
GtAwsOperationResult >> key: anObject [
	key := anObject
]

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
GtAwsOperationResult >> typeDescription [
	^ self types at: resultType
]

{ #category : #accessing }
GtAwsOperationResult >> types [
	^ types
]

{ #category : #accessing }
GtAwsOperationResult >> types: anObject [
	types := anObject
]
