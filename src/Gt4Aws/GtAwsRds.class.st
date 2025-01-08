Class {
	#name : #GtAwsRds,
	#superclass : #GtAwsEntityHolder,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsRds >> entityId [
	^ 'AWS::RDS::Instance'
]

{ #category : #accessing }
GtAwsRds >> entityName [
	^ 'Databases'
]

{ #category : #accessing }
GtAwsRds >> refreshEntities [
	^ self client rdsDescribeInstances
]

{ #category : #accessing }
GtAwsRds >> serviceName [
	^ 'AWS Relational Database Service'
]

{ #category : #accessing }
GtAwsRds >> viewName [
	^ #gtDatabasesFor:
]
