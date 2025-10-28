Class {
	#name : #GtAwsCloudformationTreeResourceGroup,
	#superclass : #Object,
	#instVars : [
		'group',
		'resourceType'
	],
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> group [
	^ group
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> group: anObject [
	group := anObject
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> gtViewResourcesFor: aView [
	<gtView>
	^ aView forward
		title: 'Resources';
		priority: 1;
		object: [ self group ];
		view: #gtResourcesFor:
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self resourceType;
		nextPut: $)
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> resourceType [
	^ resourceType
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> resourceType: anObject [
	resourceType := anObject
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> statusLabel [
	^ ''
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> treeChildren [
	^ self group
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> treeId [
	^ self resourceType
]

{ #category : #accessing }
GtAwsCloudformationTreeResourceGroup >> treeType [
	^ 'Stack resource group'
]
