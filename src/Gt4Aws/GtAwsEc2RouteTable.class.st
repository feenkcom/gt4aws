Class {
	#name : #GtAwsEc2RouteTable,
	#superclass : #GtAwsObject,
	#instVars : [
		'vpcId',
		'tags',
		'id',
		'ownerId',
		'routes'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEc2RouteTable class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
		vpcId: (aDict at: 'VpcId');
		tags: (aDict at: 'Tags');
		id: (aDict at: 'RouteTableId');
		ownerId: (aDict at: 'OwnerId');
		routes: (aDict at: 'Routes')
]

{ #category : #'as yet unclassified' }
GtAwsEc2RouteTable >> gtRoutesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Routes';
		priority: 1;
		items: [ self routes ];
		column: 'Destination CIDR block'
			text: [ :aDict | aDict at: 'DestinationCidrBlock' ];
		column: 'Gateway' text: [ :aDict | aDict at: 'GatewayId' ];
		column: 'Origin' text: [ :aDict | aDict at: 'Origin' ];
		column: 'State' text: [ :aDict | aDict at: 'State' ]
]

{ #category : #accessing }
GtAwsEc2RouteTable >> id [
	^ id
]

{ #category : #accessing }
GtAwsEc2RouteTable >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
GtAwsEc2RouteTable >> owner [
	^ self client organizations lookupAccount: self ownerId
]

{ #category : #accessing }
GtAwsEc2RouteTable >> ownerId [
	^ ownerId
]

{ #category : #accessing }
GtAwsEc2RouteTable >> ownerId: anObject [
	ownerId := anObject
]

{ #category : #accessing }
GtAwsEc2RouteTable >> routes [
	^ routes
]

{ #category : #accessing }
GtAwsEc2RouteTable >> routes: anObject [
	routes := anObject
]

{ #category : #accessing }
GtAwsEc2RouteTable >> tags [
	^ tags
]

{ #category : #accessing }
GtAwsEc2RouteTable >> tags: anObject [
	tags := anObject
]

{ #category : #'as yet unclassified' }
GtAwsEc2RouteTable >> vpc [
	^ self client ec2 vpcAt: self vpcId
]

{ #category : #accessing }
GtAwsEc2RouteTable >> vpcId [
	^ vpcId
]

{ #category : #accessing }
GtAwsEc2RouteTable >> vpcId: anObject [
	vpcId := anObject
]
