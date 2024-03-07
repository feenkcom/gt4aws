Class {
	#name : #GtAwsS3Bucket,
	#superclass : #GtAwsObject,
	#instVars : [
		'modifiedAt',
		'name',
		'tags'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3Bucket class >> lookupEndpoint [
	^ #s3GetBucket:
]

{ #category : #accessing }
GtAwsS3Bucket class >> resourceType [
	^ 'AWS::S3::Bucket'
]

{ #category : #accessing }
GtAwsS3Bucket >> lookupInCloudFormation [
	^ self client cloudformation lookupObject: self name
]

{ #category : #accessing }
GtAwsS3Bucket >> managementConsoleUrl [
	^ 'https://s3.console.aws.amazon.com/s3/buckets/', self name
]

{ #category : #accessing }
GtAwsS3Bucket >> modifiedAt [
	^ modifiedAt
]

{ #category : #accessing }
GtAwsS3Bucket >> modifiedAt: anObject [
	modifiedAt := anObject
]

{ #category : #accessing }
GtAwsS3Bucket >> name [
	^ name
]

{ #category : #accessing }
GtAwsS3Bucket >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAwsS3Bucket >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtAwsS3Bucket >> refreshTags [
	^ tags := ((self client s3ListTagsForBucket: self name)
			collect: [ :aDict | (aDict at: 'Key') -> (aDict at: 'Value') ]) asDictionary
]

{ #category : #accessing }
GtAwsS3Bucket >> tagAt: aName [
	^ self tags at: aName
]

{ #category : #accessing }
GtAwsS3Bucket >> tags [
	^ tags ifNil: [ self refreshTags ]
]
