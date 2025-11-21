Class {
	#name : #GtAwsEfs,
	#superclass : #GtAwsEntityHolder,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEfs >> entityId [
	^ 'AWS::EFS::FileSystem'
]

{ #category : #accessing }
GtAwsEfs >> entityName [
	^ 'File systems'
]

{ #category : #accessing }
GtAwsEfs >> refreshEntities [
	^ self client efsListFileSystems
]

{ #category : #accessing }
GtAwsEfs >> serviceName [
	^ 'AWS Elastic File System'
]
