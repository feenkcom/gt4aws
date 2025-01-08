Class {
	#name : #GtAwsS3,
	#superclass : #GtAwsEntityHolder,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3 >> entityId [
	^ 'AWS::S3::Bucket'
]

{ #category : #accessing }
GtAwsS3 >> entityName [
	^ 'Buckets'
]

{ #category : #accessing }
GtAwsS3 >> refreshEntities [
	^ self client s3Ls
]

{ #category : #accessing }
GtAwsS3 >> serviceName [
	^ 'AWS Simple Storage Service'
]

{ #category : #accessing }
GtAwsS3 >> viewName [
	^ #gtBucketsFor:
]
