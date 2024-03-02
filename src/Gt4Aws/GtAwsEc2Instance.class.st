Class {
	#name : #GtAwsEc2Instance,
	#superclass : #GtAwsObject,
	#instVars : [
		'id',
		'type',
		'launchTime'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEc2Instance class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
		id: (aDict at: 'InstanceId');
		type: (aDict at: 'InstanceType');
		launchTime: (DateAndTime fromString: (aDict at: 'LaunchTime'))
]

{ #category : #accessing }
GtAwsEc2Instance >> id [
	^ id
]

{ #category : #accessing }
GtAwsEc2Instance >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GtAwsEc2Instance >> launchTime [
	^ launchTime
]

{ #category : #accessing }
GtAwsEc2Instance >> launchTime: anObject [
	launchTime := anObject
]

{ #category : #accessing }
GtAwsEc2Instance >> lookupInCloudFormation [
	^ self client cloudformation lookupObject: self id
]

{ #category : #accessing }
GtAwsEc2Instance >> type [
	^ type
]

{ #category : #accessing }
GtAwsEc2Instance >> type: anObject [
	type := anObject
]
