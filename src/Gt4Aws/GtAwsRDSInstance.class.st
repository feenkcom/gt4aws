Class {
	#name : #GtAwsRDSInstance,
	#superclass : #GtAwsObject,
	#instVars : [
		'name',
		'status',
		'instanceClass',
		'id'
	],
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsRDSInstance class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
		name: (aDict at: 'DBName');
		status: (aDict at: 'DBInstanceStatus');
		instanceClass: (aDict at: 'DBInstanceClass');
		id: (aDict at:'DBInstanceIdentifier')
]

{ #category : #accessing }
GtAwsRDSInstance class >> lookupEndpoint [
	^ #rdsDescribeInstance:
]

{ #category : #accessing }
GtAwsRDSInstance class >> resourceType [
	^ 'AWS::RDS::DBInstance'
]

{ #category : #accessing }
GtAwsRDSInstance >> gtTagsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'TagList';
		priority: 5;
		items: [ self jsonObject at: 'Tags' ];
		column: 'Name' text: [ :aTag | aTag at: 'Key' ];
		column: 'Value' text: [ :aTag | aTag at: 'Value' ]
]

{ #category : #accessing }
GtAwsRDSInstance >> id [
	^ id
]

{ #category : #accessing }
GtAwsRDSInstance >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GtAwsRDSInstance >> instanceClass [
	^ instanceClass
]

{ #category : #accessing }
GtAwsRDSInstance >> instanceClass: anObject [
	instanceClass := anObject
]

{ #category : #accessing }
GtAwsRDSInstance >> lookupInCloudFormation [
	^ self client cloudformation lookupObject: self id
]

{ #category : #accessing }
GtAwsRDSInstance >> managementConsoleProperties [
	^ 'database:id=', self id
]

{ #category : #accessing }
GtAwsRDSInstance >> name [
	^ name
]

{ #category : #accessing }
GtAwsRDSInstance >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAwsRDSInstance >> status [
	^ status
]

{ #category : #accessing }
GtAwsRDSInstance >> status: anObject [
	status := anObject
]

{ #category : #accessing }
GtAwsRDSInstance >> tagAt: aName [
	^ (self jsonObject at: 'TagList')
		detect: [ :aTag | (aTag at: 'Key') = aName ]
		ifOne: [ :aTag | aTag at: 'Value' ]
]

{ #category : #accessing }
GtAwsRDSInstance >> urlBaseName [
	^ 'rds'
]
