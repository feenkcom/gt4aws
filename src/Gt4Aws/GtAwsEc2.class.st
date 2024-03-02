Class {
	#name : #GtAwsEc2,
	#superclass : #Object,
	#instVars : [
		'client'
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
GtAwsEc2 >> instances [
	^ self client ec2ListInstances
]

{ #category : #accessing }
GtAwsEc2 >> printOn: aStream [
	aStream nextPutAll: 'AWS Elastic Compute Cloud'
]
