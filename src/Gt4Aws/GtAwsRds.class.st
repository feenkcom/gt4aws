Class {
	#name : #GtAwsRds,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsRds >> client [
	^ client
]

{ #category : #accessing }
GtAwsRds >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsRds >> databases [
	^ self client rdsDescribeInstances
]

{ #category : #accessing }
GtAwsRds >> gtDisplayOn: stream [
	stream nextPutAll: 'AWS Relational Database Service'
]

{ #category : #accessing }
GtAwsRds >> gtListDatabasesFor: aView [
	<gtView>
	^ aView forward
		title: 'Databases';
		priority: 1;
		object: [ self databases ];
		view: #gtDatabasesFor:
]
