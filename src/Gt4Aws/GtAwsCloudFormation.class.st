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
	^ aView columnedList
		title: 'Stacks';
		priority: 1;
		items: [ self stacks ];
		column: 'Stack name' text: #name;
		column: 'Description' text: [ :each | each templateDescription ifNil: [ '' ] ];
		column: 'Status' text: #statusLabel
]

{ #category : #requests }
GtAwsCloudFormation >> stacks [
	<return: #Collection of: #S3CloudformationStack>
	^ client cloudformationListStacks
]
