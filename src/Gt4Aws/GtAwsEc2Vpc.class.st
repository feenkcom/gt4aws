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
		'state'
	],
	#category : #'Gt4Aws-Model'
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

{ #category : #accessing }
GtAwsEc2Vpc >> ownerId [
	^ ownerId
]

{ #category : #accessing }
GtAwsEc2Vpc >> ownerId: anObject [
	ownerId := anObject
]

{ #category : #accessing }
GtAwsEc2Vpc >> state [
	^ state
]

{ #category : #accessing }
GtAwsEc2Vpc >> state: anObject [
	state := anObject
]
