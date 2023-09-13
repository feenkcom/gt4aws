Class {
	#name : #GtAwsObject,
	#superclass : #Object,
	#instVars : [
		'jsonObject'
	],
	#category : #Gt4Aws
}

{ #category : #'instance  creation' }
GtAwsObject class >> jsonObject: aJsonObject [

	^ self new jsonObject: aJsonObject
]

{ #category : #accessing }
GtAwsObject >> gtRawInfoFor: aView [
	<gtView>

	jsonObject ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Raw Info';
		priority: 40;
		object: [ jsonObject ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtAwsObject >> jsonObject [

	^ jsonObject
]

{ #category : #accessing }
GtAwsObject >> jsonObject: anObject [

	jsonObject := anObject
]
