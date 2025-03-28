Class {
	#name : #GtAwsObject,
	#superclass : #Object,
	#instVars : [
		'jsonObject',
		'client'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsObject class >> forResourceType: aResourceType [
	^ self
		forResourceType: aResourceType
		ifNotFound: [ self error: 'Object for AWS resource type ' , aResourceType , ' not found' ]
]

{ #category : #accessing }
GtAwsObject class >> forResourceType: aResourceType ifNotFound: aBlock [
	self
		subclassesDo: [ :aClass | aClass resourceType = aResourceType ifTrue: [ ^ aClass ] ].

	^ aBlock value
]

{ #category : #'as yet unclassified' }
GtAwsObject class >> fromDictionary: aDict [
	^ self new jsonObject: aDict
]

{ #category : #'instance  creation' }
GtAwsObject class >> jsonObject: aJsonObject [

	^ self new jsonObject: aJsonObject
]

{ #category : #accessing }
GtAwsObject class >> lookup: anId inClient: aClient [
	^ aClient find: self resourceType orFind: anId InEndpoint: self lookupEndpoint
]

{ #category : #accessing }
GtAwsObject class >> lookupEndpoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsObject class >> resourceType [
	^ ''
]

{ #category : #accessing }
GtAwsObject >> client [
	^ client
]

{ #category : #accessing }
GtAwsObject >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsObject >> gtLookupInCloudFormationActionFor: anAction [
	<gtAction>
	^ anAction button
		priority: 5;
		icon: BrGlamorousVectorIcons playinspect;
		tooltip: 'Lookup in CloudFormation';
		action: [ :aButton | aButton phlow spawnObject: self lookupInCloudFormation ]
]

{ #category : #accessing }
GtAwsObject >> gtManagementConsoleFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons window;
		tooltip: 'Open in ManagementConsole';
		action: [ :aButton | WebBrowser openOn: self managementConsoleUrl ]
]

{ #category : #accessing }
GtAwsObject >> gtRawInfoFor: aView [
	<gtView>

	jsonObject ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Raw Info';
		priority: 40;
		object: [ jsonObject ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtAwsObject >> jsonObject [

	^ jsonObject
]

{ #category : #accessing }
GtAwsObject >> jsonObject: anObject [

	jsonObject := anObject
]

{ #category : #accessing }
GtAwsObject >> lookupInCloudFormation [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsObject >> managementConsoleProperties [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsObject >> managementConsoleUrl [
	^ 'https://' , self client awsRegion , '.console.aws.amazon.com/'
		, self urlBaseName , '/home?region=' , self client awsRegion , '#'
		, self managementConsoleProperties
]

{ #category : #accessing }
GtAwsObject >> tagAt: aName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsObject >> urlBaseName [
	^ 'organizations/v2'
]
