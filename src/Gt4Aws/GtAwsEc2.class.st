Class {
	#name : #GtAwsEc2,
	#superclass : #GtAwsEntityHolder,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEc2 >> entityId [
	^ 'AWS::EC2::Instance'
]

{ #category : #accessing }
GtAwsEc2 >> entityName [
	^ 'Instances'
]

{ #category : #accessing }
GtAwsEc2 >> entitySearchKey [
	^ #id
]

{ #category : #accessing }
GtAwsEc2 >> refreshEntities [
	^ self client ec2ListInstances
]

{ #category : #accessing }
GtAwsEc2 >> serviceName [
	^ 'AWS Elastic Compute Cloud'
]

{ #category : #accessing }
GtAwsEc2 >> viewName [
	^ #gtInstancesFor:
]
