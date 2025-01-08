Class {
	#name : #GtAwsEc2TransitGateway,
	#superclass : #GtAwsObject,
	#instVars : [
		'id',
		'arn',
		'state',
		'ownerId',
		'description',
		'creationTime',
		'tags'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEc2TransitGateway class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
		id: (aDict at: 'TransitGatewayId');
		arn: (aDict at: 'TransitGatewayArn');
		state: (aDict at: 'State');
		ownerId: (aDict at: 'OwnerId');
		description: (aDict at: 'Description');
		creationTime: (DateAndTime fromString: (aDict at: 'CreationTime'));
		tags: (aDict at: 'Tags')
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> arn [
	^ arn
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> arn: anObject [
	arn := anObject
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> creationTime [
	^ creationTime
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> creationTime: anObject [
	creationTime := anObject
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> description [
	^ description
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> id [
	^ id
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
GtAwsEc2TransitGateway >> owner [
	^ self client organizations lookupAccount: self ownerId
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> ownerId [
	^ ownerId
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> ownerId: anObject [
	ownerId := anObject
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> state [
	^ state
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> state: anObject [
	state := anObject
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> tags [
	^ tags
]

{ #category : #accessing }
GtAwsEc2TransitGateway >> tags: anObject [
	tags := anObject
]
