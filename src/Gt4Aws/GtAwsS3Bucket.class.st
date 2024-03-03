Class {
	#name : #GtAwsS3Bucket,
	#superclass : #GtAwsObject,
	#instVars : [
		'modifiedAt',
		'name'
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
