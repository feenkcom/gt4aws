Class {
	#name : #GtAwsCloudformationStackResource,
	#superclass : #GtAwsObject,
	#instVars : [
		'logicalResourceId',
		'physicalResourceId',
		'resourceType',
		'lastUpdated',
		'status',
		'driftInformation',
		'stack',
		'resourceObject'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCloudformationStackResource class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
		logicalResourceId: (aDict at: 'LogicalResourceId');
		physicalResourceId: (aDict at: 'PhysicalResourceId' ifAbsent: [ nil ]);
		status: (aDict at: 'ResourceStatus');
		lastUpdated: (aDict
				at: 'LastUpdatedTime'
				ifPresent: [ :aString | DateAndTime fromString: aString ]
				ifAbsent: [ nil ]);
		resourceType: (aDict at: 'ResourceType');
		driftInformation: (aDict at: 'DriftInformation')
]

{ #category : #accessing }
GtAwsCloudformationStackResource class >> gtGroupType [
	^ GtAwsCloudFormationStackResourceGroup
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> driftInformation [
	^ driftInformation
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> driftInformation: anObject [
	driftInformation := anObject
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> gtInspectResourceFor: anAction [
	<gtAction>
	self hasResourceClass ifFalse: [ ^ anAction noAction ].

	^ anAction button
		icon: BrGlamorousVectorIcons playinspect;
		tooltip: 'Inspect Resource';
		priority: 5;
		action: [ :aButton | aButton phlow spawnObject: self resourceObject ]
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> gtLookupInCloudFormationActionFor: anAction [
	<gtAction>
	^ anAction noAction
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> hasResourceClass [
	^ (GtAwsObject forResourceType: self resourceType ifNotFound: [ nil ]) isNotNil
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> lastUpdated [
	^ lastUpdated
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> lastUpdated: anObject [
	lastUpdated := anObject
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> logicalResourceId [
	^ logicalResourceId
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> logicalResourceId: anObject [
	logicalResourceId := anObject
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> managementConsoleProperties [
	^ '/stacks/resources?stackId=' , self stack id
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> physicalResourceId [
	^ physicalResourceId
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> physicalResourceId: anObject [
	physicalResourceId := anObject
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self resourceType;
		nextPut: $)
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> resourceClass [
	^ GtAwsObject forResourceType: self resourceType
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> resourceObject [
	^ resourceObject
		ifNil: [ resourceObject := self resourceClass
					lookup: self physicalResourceId
					inClient: self client ]
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> resourceObjectOrNil [
	^ [ self resourceClass lookup: self physicalResourceId inClient: self client ]
		on: Error
		do: [ nil ]
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> resourceType [
	^ resourceType
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> resourceType: anObject [
	resourceType := anObject
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> resourceTypeGroup [
	^ ('::' split: self resourceType) second
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> stack [
	^ stack
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> stack: anObject [
	stack := anObject
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> status [
	^ status
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> status: anObject [
	status := anObject
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> statusLabel [
	^ (GtAwsStatus forName: status) label
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> treeChildren [
	^ {}
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> treeId [
	^ self logicalResourceId
]

{ #category : #accessing }
GtAwsCloudformationStackResource >> treeType [
	^ 'Stack resource'
]

{ #category : #'as yet unclassified' }
GtAwsCloudformationStackResource >> urlBaseName [
	^ 'cloudformation'
]
