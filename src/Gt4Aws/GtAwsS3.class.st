Class {
	#name : #GtAwsS3,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3 >> buckets [
	^ self client s3Ls
]

{ #category : #accessing }
GtAwsS3 >> client [
	^ client
]

{ #category : #accessing }
GtAwsS3 >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsS3 >> gtBucketsFor: aView [
	<gtView>
	^ aView forward
		title: 'Buckets';
		priority: 1;
		object: [ self buckets ];
		view: #gtBucketsFor:
]

{ #category : #accessing }
GtAwsS3 >> printOn: aStream [
	aStream nextPutAll: 'AWS Simple Storage Service'
]
