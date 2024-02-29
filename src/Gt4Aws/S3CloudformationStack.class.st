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
		'client',
		'resources'
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
S3CloudformationStack class >> gtGroupType [
	^ S3CloudformationStackGroup
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
S3CloudformationStack >> gtRefreshResourcesFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons refresh;
		tooltip: 'Refresh resources';
		priority: 3;
		action: [ self refreshResources ]
]

{ #category : #accessing }
S3CloudformationStack >> gtSearchResourcesFor: aSearch [
	<gtSearch>
		^ aSearch list
		title: 'Resources';
		priority: 30;
		items: [ self resources ];
		itemsLimit: Float infinity;
		itemName: #logicalResourceId;
		filterBySubstring
]

{ #category : #accessing }
S3CloudformationStack >> gtViewResourcesByStatusFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Resources by status';
		priority: 2;
		items: [ self resourcesByStacks associations ];
		column: 'Status' text: #key;
		column: '# of resources' text: [:aPair | aPair value size ];
		send: #value
]

{ #category : #accessing }
S3CloudformationStack >> gtViewResourcesFor: aView [
	<gtView>
	^ aView forward
		title: 'Resources';
		priority: 1;
		object: [ self resources ];
		view: #gtResourcesFor:
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
S3CloudformationStack >> refreshResources [
	^ resources := self client cloudformationListStackResourcesFor: self id
]

{ #category : #accessing }
S3CloudformationStack >> resources [
	^ resources ifNil: [ self refreshResources ]
]

{ #category : #accessing }
S3CloudformationStack >> resourcesByStacks [
	^ self resources groupedBy: #status
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
S3CloudformationStack >> statusLabel [
	^ (GtAwsStatus forName: status) label
]

{ #category : #accessing }
S3CloudformationStack >> templateDescription [
	^ templateDescription
]

{ #category : #accessing }
S3CloudformationStack >> templateDescription: anObject [
	templateDescription := anObject
]
