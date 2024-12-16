Class {
	#name : #GtAwsEc2,
	#superclass : #GtAwsEntityHolder,
	#instVars : [
		'instanceTypes',
		'vpcs'
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
GtAwsEc2 >> gtVpcsFor: aView [
	<gtView>
	^ aView forward
		title: 'VPCs';
		priority: 5;
		object: [ self vpcs ];
		view: #gtVpcsFor:
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

{ #category : #'as yet unclassified' }
GtAwsEc2 >> refreshVpcs [
	^ instanceTypes := self client ec2ListVpcs
]

{ #category : #accessing }
GtAwsEc2 >> serviceName [
	^ 'AWS Elastic Compute Cloud'
]

{ #category : #accessing }
GtAwsEc2 >> viewName [
	^ #gtInstancesFor:
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> vpcs [
	^ vpcs ifNil: [ self refreshVpcs ]
]
