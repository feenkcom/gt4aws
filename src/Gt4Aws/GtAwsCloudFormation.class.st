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

{ #category : #accessing }
GtAwsCloudFormation >> gtSearchStacksFor: aSearch [
	<gtSearch>
		^ aSearch list
		title: 'Stacks';
		priority: 30;
		items: [ self stacks ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
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
	<return: #S3CloudformationStackGroup>
	^ client cloudformationListStacks
]
