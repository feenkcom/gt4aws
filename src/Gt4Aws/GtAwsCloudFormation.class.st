Class {
	#name : #GtAwsCloudFormation,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'Gt4Aws-Modelel'
}

{ #category : #accessing }
GtAwsCloudFormation >> client [
	<return: #GtAwsAmazonWebServices>
	^ client
]

{ #category : #accessing }
GtAwsCloudFormation >> client: anObject [
	client := anObject
]

{ #category : #printing }
GtAwsCloudFormation >> gtDisplayOn: stream [
	stream nextPutAll: 'AWS CloudFormation'
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> gtStacksFor: aView [
	<gtView>
	client ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stacks';
		priority: 1;
		object: [ self stacks ];
		view: #gtStacksFor:
]

{ #category : #requests }
GtAwsCloudFormation >> stacks [
	<return: #Collection of: #S3CloudformationStack>
	^ client cloudformationListStacks
]
