Class {
	#name : #GtAwsEc2,
	#superclass : #GtAwsEntityHolder,
	#instVars : [
		'instanceTypes',
		'vpcs',
		'routeTables',
		'transitGateways'
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
GtAwsEc2 >> gtRouteTablesFor: aView [
	<gtView>
	^ aView forward
		title: 'Route tables';
		priority: 6;
		object: [ self routeTables ];
		view: #gtRouteTablesFor:
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> gtTransitGatewaysFor: aView [
	<gtView>
	^ aView forward
		title: 'Transit gateways';
		priority: 7;
		object: [ self transitGateways ];
		view: #gtTransitGatewaysFor:
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
GtAwsEc2 >> refreshRouteTables [
	^ routeTables := self client ec2ListRouteTables
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> refreshTransitGateways [
	^ transitGateways := self client ec2ListTransitGateways
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> refreshVpcs [
	^ vpcs := self client ec2ListVpcs
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> routeTables [
	^ routeTables ifNil: [ self refreshRouteTables ]
]

{ #category : #accessing }
GtAwsEc2 >> serviceName [
	^ 'AWS Elastic Compute Cloud'
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> transitGateways [
	^ transitGateways ifNil: [ self refreshTransitGateways ]
]

{ #category : #accessing }
GtAwsEc2 >> viewName [
	^ #gtInstancesFor:
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> vpcAt: anId [
	^ self vpcs detect: [ :aVpc | aVpc id = anId ]
]

{ #category : #'as yet unclassified' }
GtAwsEc2 >> vpcs [
	^ vpcs ifNil: [ self refreshVpcs ]
]
