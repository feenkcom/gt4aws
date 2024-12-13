Class {
	#name : #GtAwsEc2,
	#superclass : #GtAwsEntityHolder,
	#instVars : [
		'instanceTypes'
	],
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

{ #category : #'as yet unclassified' }
GtAwsEc2 >> instanceTypes [
	^ instanceTypes ifNil: [ self refreshInstanceTypes ]
]

{ #category : #accessing }
GtAwsEc2 >> refreshEntities [
	^ self client ec2ListInstances
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> refreshInstanceTypes [
	^ instanceTypes := self client ec2InstanceTypes
]

{ #category : #accessing }
GtAwsEc2 >> serviceName [
	^ 'AWS Elastic Compute Cloud'
]

{ #category : #accessing }
GtAwsEc2 >> viewName [
	^ #gtInstancesFor:
]
