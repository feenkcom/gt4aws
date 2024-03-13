Class {
	#name : #GtAwsS3,
	#superclass : #Object,
	#instVars : [
		'client',
		'buckets'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3 >> buckets [
	^ buckets ifNil: [ self refreshBuckets ]
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
GtAwsS3 >> gtRefreshBucketsFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		tooltip: 'Refresh buckets';
		icon: BrGlamorousVectorIcons refresh;
		action: [ self refreshBuckets ]
]

{ #category : #accessing }
GtAwsS3 >> gtSearchBucketsFor: aSearch [
	<gtSearch>
		^ aSearch list
		title: 'Buckets';
		priority: 30;
		items: [ self buckets ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
]

{ #category : #accessing }
GtAwsS3 >> printOn: aStream [
	aStream nextPutAll: 'AWS Simple Storage Service'
]

{ #category : #accessing }
GtAwsS3 >> refreshBuckets [
	^ buckets := self client s3Ls
]
