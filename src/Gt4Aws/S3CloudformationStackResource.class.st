Class {
	#name : #S3CloudformationStackResource,
	#superclass : #Object,
	#instVars : [
		'logicalResourceId',
		'physicalResourceId',
		'resourceType',
		'lastUpdated',
		'status',
		'driftInformation',
		'client'
	],
	#category : #'Gt4Aws-Client'
}

{ #category : #accessing }
S3CloudformationStackResource class >> fromDictionary: aDict [
	^ self new
		logicalResourceId: (aDict at: 'LogicalResourceId');
		physicalResourceId: (aDict at: 'PhysicalResourceId');
		status: (aDict at: 'ResourceStatus');
		lastUpdated: (aDict
				at: 'LastUpdatedTime'
				ifPresent: [ :aString | DateAndTime fromString: aString ]
				ifAbsent: [ nil ]);
		resourceType: (aDict at: 'ResourceType');
		driftInformation: (aDict at: 'DriftInformation')
]

{ #category : #accessing }
S3CloudformationStackResource >> client [
	^ client
]

{ #category : #accessing }
S3CloudformationStackResource >> client: anObject [
	client := anObject
]

{ #category : #accessing }
S3CloudformationStackResource >> driftInformation [
	^ driftInformation
]

{ #category : #accessing }
S3CloudformationStackResource >> driftInformation: anObject [
	driftInformation := anObject
]

{ #category : #accessing }
S3CloudformationStackResource >> lastUpdated [
	^ lastUpdated
]

{ #category : #accessing }
S3CloudformationStackResource >> lastUpdated: anObject [
	lastUpdated := anObject
]

{ #category : #accessing }
S3CloudformationStackResource >> logicalResourceId [
	^ logicalResourceId
]

{ #category : #accessing }
S3CloudformationStackResource >> logicalResourceId: anObject [
	logicalResourceId := anObject
]

{ #category : #accessing }
S3CloudformationStackResource >> physicalResourceId [
	^ physicalResourceId
]

{ #category : #accessing }
S3CloudformationStackResource >> physicalResourceId: anObject [
	physicalResourceId := anObject
]

{ #category : #accessing }
S3CloudformationStackResource >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self resourceType;
		nextPut: $)
]

{ #category : #accessing }
S3CloudformationStackResource >> resourceType [
	^ resourceType
]

{ #category : #accessing }
S3CloudformationStackResource >> resourceType: anObject [
	resourceType := anObject
]

{ #category : #accessing }
S3CloudformationStackResource >> status [
	^ status
]

{ #category : #accessing }
S3CloudformationStackResource >> status: anObject [
	status := anObject
]
