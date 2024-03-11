Class {
	#name : #GtAwsCloudformationStack,
	#superclass : #GtAwsObject,
	#instVars : [
		'id',
		'status',
		'name',
		'lastUpdated',
		'created',
		'deleted',
		'templateDescription',
		'driftInformation',
		'resources'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCloudformationStack class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
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
GtAwsCloudformationStack class >> gtGroupType [
	^ GtAwsCloudformationStackGroup
]

{ #category : #accessing }
GtAwsCloudformationStack >> created [
	^ created
]

{ #category : #accessing }
GtAwsCloudformationStack >> created: anObject [
	created := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> deleted [
	^ deleted
]

{ #category : #accessing }
GtAwsCloudformationStack >> deleted: anObject [
	deleted := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> driftInformation [
	^ driftInformation
]

{ #category : #accessing }
GtAwsCloudformationStack >> driftInformation: anObject [
	driftInformation := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> gtGraphFor: aView [
	<gtView>
	^ aView explicit
		title: 'Graph';
		priority: 10;
		stencil: [ GtAwsCloudFormationStackElement new stack: self ]
]

{ #category : #accessing }
GtAwsCloudformationStack >> gtRefreshResourcesFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons refresh;
		tooltip: 'Refresh resources';
		priority: 3;
		action: [ self refreshResources ]
]

{ #category : #accessing }
GtAwsCloudformationStack >> gtSearchResourcesFor: aSearch [
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
GtAwsCloudformationStack >> gtViewResourcesByStatusFor: aView [
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
GtAwsCloudformationStack >> gtViewResourcesFor: aView [
	<gtView>
	^ aView forward
		title: 'Resources';
		priority: 1;
		object: [ self resources ];
		view: #gtResourcesFor:
]

{ #category : #accessing }
GtAwsCloudformationStack >> id [
	^ id
]

{ #category : #accessing }
GtAwsCloudformationStack >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> isDeleted [
	^ self status = 'DELETE_COMPLETE'
]

{ #category : #accessing }
GtAwsCloudformationStack >> lastTouched [
	| lastTouched |
	lastTouched := created.
	
	lastUpdated ifNotNil: [ lastTouched := lastTouched max: lastUpdated ].
	deleted ifNotNil: [ lastTouched := lastTouched max: deleted ].

	^ lastTouched
]

{ #category : #accessing }
GtAwsCloudformationStack >> lastUpdated [
	^ lastUpdated
]

{ #category : #accessing }
GtAwsCloudformationStack >> lastUpdated: anObject [
	lastUpdated := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> name [
	^ name
]

{ #category : #accessing }
GtAwsCloudformationStack >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtAwsCloudformationStack >> refreshResources [
	^ resources := GtAwsCloudFormationStackResourceGroup
			withAll: ((self client cloudformationListStackResourcesFor: self id)
					collect: [ :aResource | aResource stack: self ])
]

{ #category : #accessing }
GtAwsCloudformationStack >> resources [
	^ resources ifNil: [ self refreshResources ]
]

{ #category : #accessing }
GtAwsCloudformationStack >> resourcesByStacks [
	^ self resources groupedBy: #status
]

{ #category : #accessing }
GtAwsCloudformationStack >> status [
	^ status
]

{ #category : #accessing }
GtAwsCloudformationStack >> status: anObject [
	status := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> statusLabel [
	^ (GtAwsStatus forName: status) label
]

{ #category : #accessing }
GtAwsCloudformationStack >> templateDescription [
	^ templateDescription
]

{ #category : #accessing }
GtAwsCloudformationStack >> templateDescription: anObject [
	templateDescription := anObject
]

{ #category : #accessing }
GtAwsCloudformationStack >> treeChildren [
	^ (self resources groupedBy: #resourceType)
		collect: [ :aResourceGroup | 
			GtAwsCloudformationTreeResourceGroup new
				group: aResourceGroup;
				resourceType: aResourceGroup first resourceType ]
]

{ #category : #accessing }
GtAwsCloudformationStack >> treeId [
	^ self name
]

{ #category : #accessing }
GtAwsCloudformationStack >> treeType [
	^ 'Stack'
]
