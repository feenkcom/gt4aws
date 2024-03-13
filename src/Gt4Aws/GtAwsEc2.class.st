Class {
	#name : #GtAwsEc2,
	#superclass : #Object,
	#instVars : [
		'client',
		'instances'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEc2 >> client [
	^ client
]

{ #category : #accessing }
GtAwsEc2 >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsEc2 >> gtInstancesFor: aView [
	<gtView>
	^ aView forward
		title: 'Instances';
		priority: 1;
		object: [ self instances ];
		view: #gtInstancesFor:
]

{ #category : #accessing }
GtAwsEc2 >> gtRefreshInstancesFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		tooltip: 'Refresh instances';
		icon: BrGlamorousVectorIcons refresh;
		action: [ self refreshInstances ]
]

{ #category : #accessing }
GtAwsEc2 >> gtSearchInstancesFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Instances';
		priority: 30;
		items: [ self instances ];
		itemsLimit: Float infinity;
		itemName: #id;
		filterBySubstring
]

{ #category : #accessing }
GtAwsEc2 >> instances [
	^ instances ifNil: [ self refreshInstances ]
]

{ #category : #accessing }
GtAwsEc2 >> printOn: aStream [
	aStream nextPutAll: 'AWS Elastic Compute Cloud'
]

{ #category : #accessing }
GtAwsEc2 >> refreshInstances [
	^ instances := self client ec2ListInstances
]
