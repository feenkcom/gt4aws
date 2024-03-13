Class {
	#name : #GtAwsRds,
	#superclass : #Object,
	#instVars : [
		'client',
		'databases'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsRds >> client [
	^ client
]

{ #category : #accessing }
GtAwsRds >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsRds >> databases [
	^ databases ifNil: [ self refreshDatabases ]
]

{ #category : #accessing }
GtAwsRds >> gtDisplayOn: stream [
	stream nextPutAll: 'AWS Relational Database Service'
]

{ #category : #accessing }
GtAwsRds >> gtListDatabasesFor: aView [
	<gtView>
	^ aView forward
		title: 'Databases';
		priority: 1;
		object: [ self databases ];
		view: #gtDatabasesFor:
]

{ #category : #accessing }
GtAwsRds >> gtRefreshDatabasesFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		tooltip: 'Refresh databases';
		icon: BrGlamorousVectorIcons refresh;
		action: [ self refreshDatabases ]
]

{ #category : #accessing }
GtAwsRds >> gtSearchDatabasesFor: aSearch [
	<gtSearch>
		^ aSearch list
		title: 'Databases';
		priority: 30;
		items: [ self databases ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
]

{ #category : #accessing }
GtAwsRds >> refreshDatabases [
	^ databases := self client rdsDescribeInstances
]
