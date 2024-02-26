Class {
	#name : #S3CloudformationStack,
	#superclass : #Object,
	#instVars : [
		'id',
		'status',
		'name',
		'lastUpdated',
		'created',
		'deleted',
		'templateDescription',
		'driftInformation',
		'client'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
S3CloudformationStack class >> fromDictionary: aDict [
	^ self new
		id: (aDict at: 'StackId');
		status: (aDict at: 'StackStatus');
		name: (aDict at: 'StackName');
		lastUpdated: (aDict
				at: 'LastUpdatedTime'
				ifPresent: [ :aString | DateAndTime fromString: aString ]
				ifAbsent: [ nil ]);
		created: (aDict
				at: 'CreationTime'
				ifPresent: [ :aString | DateAndTime fromString: aString ]
				ifAbsent: [ nil ]);
		deleted: (aDict
				at: 'DeletionTime'
				ifPresent: [ :aString | DateAndTime fromString: aString ]
				ifAbsent: [ nil ]);
		templateDescription: (aDict at: 'TemplateDescription' ifAbsent: [ nil ]);
		driftInformation: (aDict at: 'DriftInformation')
]

{ #category : #accessing }
S3CloudformationStack >> client [
	^ client
]

{ #category : #accessing }
S3CloudformationStack >> client: anObject [
	client := anObject
]

{ #category : #accessing }
S3CloudformationStack >> created [
	^ created
]

{ #category : #accessing }
S3CloudformationStack >> created: anObject [
	created := anObject
]

{ #category : #accessing }
S3CloudformationStack >> deleted [
	^ deleted
]

{ #category : #accessing }
S3CloudformationStack >> deleted: anObject [
	deleted := anObject
]

{ #category : #accessing }
S3CloudformationStack >> driftInformation [
	^ driftInformation
]

{ #category : #accessing }
S3CloudformationStack >> driftInformation: anObject [
	driftInformation := anObject
]

{ #category : #accessing }
S3CloudformationStack >> gtViewResourcesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Resources';
		priority: 1;
		items: [ self client cloudformationListStackResourcesFor: self id ];
		column: 'Logical Resource ID' text: #logicalResourceId;
		column: 'Physical Resource ID' text: #physicalResourceId;
		column: 'Resource Type' text: #resourceType;
		column: 'Status' text: #status
]

{ #category : #accessing }
S3CloudformationStack >> id [
	^ id
]

{ #category : #accessing }
S3CloudformationStack >> id: anObject [
	id := anObject
]

{ #category : #accessing }
S3CloudformationStack >> lastUpdated [
	^ lastUpdated
]

{ #category : #accessing }
S3CloudformationStack >> lastUpdated: anObject [
	lastUpdated := anObject
]

{ #category : #accessing }
S3CloudformationStack >> name [
	^ name
]

{ #category : #accessing }
S3CloudformationStack >> name: anObject [
	name := anObject
]

{ #category : #accessing }
S3CloudformationStack >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
S3CloudformationStack >> status [
	^ status
]

{ #category : #accessing }
S3CloudformationStack >> status: anObject [
	status := anObject
]

{ #category : #accessing }
S3CloudformationStack >> templateDescription [
	^ templateDescription
]

{ #category : #accessing }
S3CloudformationStack >> templateDescription: anObject [
	templateDescription := anObject
]
