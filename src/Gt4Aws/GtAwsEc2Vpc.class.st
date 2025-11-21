Class {
	#name : #GtAwsEc2Vpc,
	#superclass : #GtAwsObject,
	#instVars : [
		'id',
		'cidrBlock',
		'isDefault',
		'instanceTenancy',
		'dhcpOptionsId',
		'ownerId',
		'state',
		'routeTables'
	],
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEc2Vpc class >> fromDictionary: aDict [ 
^ self new
		jsonObject: aDict;
		id: (aDict at: 'VpcId');
		cidrBlock: (aDict at: 'CidrBlock');
		isDefault: (aDict at: 'IsDefault');
		instanceTenancy: (aDict at: 'InstanceTenancy');
		dhcpOptionsId: (aDict at: 'DhcpOptionsId');
		ownerId: (aDict at: 'OwnerId');
		state: (aDict at: 'State')
]

{ #category : #accessing }
GtAwsEc2Vpc >> cidrBlock [
	^ cidrBlock
]

{ #category : #accessing }
GtAwsEc2Vpc >> cidrBlock: anObject [
	cidrBlock := anObject
]

{ #category : #accessing }
GtAwsEc2Vpc >> dhcpOptionsId [
	^ dhcpOptionsId
]

{ #category : #accessing }
GtAwsEc2Vpc >> dhcpOptionsId: anObject [
	dhcpOptionsId := anObject
]

{ #category : #'as yet unclassified' }
GtAwsEc2Vpc >> gtRouteTablesFor: aView [
	<gtView>
	^ aView forward
		title: 'Route tables';
		priority: 1;
		object: [ self routeTables ];
		view: #gtRouteTablesFor:
]

{ #category : #accessing }
GtAwsEc2Vpc >> id [
	^ id
]

{ #category : #accessing }
GtAwsEc2Vpc >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GtAwsEc2Vpc >> instanceTenancy [
	^ instanceTenancy
]

{ #category : #accessing }
GtAwsEc2Vpc >> instanceTenancy: anObject [
	instanceTenancy := anObject
]

{ #category : #accessing }
GtAwsEc2Vpc >> isDefault [
	^ isDefault
]

{ #category : #accessing }
GtAwsEc2Vpc >> isDefault: anObject [
	isDefault := anObject
]

{ #category : #'as yet unclassified' }
GtAwsEc2Vpc >> owner [
	^ self client organizations lookupAccount: self ownerId
]

{ #category : #accessing }
GtAwsEc2Vpc >> ownerId [
	^ ownerId
]

{ #category : #accessing }
GtAwsEc2Vpc >> ownerId: anObject [
	ownerId := anObject
]

{ #category : #'as yet unclassified' }
GtAwsEc2Vpc >> routeTables [
	^ routeTables
		ifNil: [ routeTables := self client ec2 routeTables
					select: [ :aRouteTable | aRouteTable vpcId = self id ] ]
]

{ #category : #accessing }
GtAwsEc2Vpc >> state [
	^ state
]

{ #category : #accessing }
GtAwsEc2Vpc >> state: anObject [
	state := anObject
]
