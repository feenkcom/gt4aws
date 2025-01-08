Class {
	#name : #GtAwsOrganizationsAccount,
	#superclass : #GtAwsObject,
	#instVars : [
		'status',
		'name',
		'id',
		'arn',
		'email',
		'joinedMethod',
		'joinedTimestamp'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsOrganizationsAccount class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
		status: (aDict at: 'Status');
		name: (aDict at: 'Name');
		id: (aDict at: 'Id');
		arn: (aDict at: 'Arn');
		email: (aDict at: 'Email');
		joinedMethod: (aDict at: 'JoinedMethod');
		joinedTimestamp: (DateAndTime fromString: (aDict at: 'JoinedTimestamp'))
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> arn [
	^ arn
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> arn: anObject [
	arn := anObject
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> email [
	^ email
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> email: anObject [
	email := anObject
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> id [
	^ id
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> joinedMethod [
	^ joinedMethod
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> joinedMethod: anObject [
	joinedMethod := anObject
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> joinedTimestamp [
	^ joinedTimestamp
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> joinedTimestamp: anObject [
	joinedTimestamp := anObject
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> lookupInCloudFormation [
	^ self client cloudformation lookupObject: self id
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> managementConsoleProperties [
	^ '/accounts/', self id
]

{ #category : #'as yet unclassified' }
GtAwsOrganizationsAccount >> managementConsoleUrl [
	^ 'https://' , self client awsRegion , '.console.aws.amazon.com/'
		, self urlBaseName , '/home' , self managementConsoleProperties
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> name [
	^ name
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> status [
	^ status
]

{ #category : #accessing }
GtAwsOrganizationsAccount >> status: anObject [
	status := anObject
]
