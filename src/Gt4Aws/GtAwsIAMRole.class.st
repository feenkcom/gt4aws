Class {
	#name : #GtAwsIAMRole,
	#superclass : #GtAwsObject,
	#instVars : [
		'roleId',
		'arn',
		'roleName',
		'createDate',
		'maxSessionDuration',
		'path'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsIAMRole class >> fromDictionary: aDict [
	| anInstance |
	anInstance := self new jsonObject: aDict.

	anInstance
		roleId: (aDict at: 'RoleId');
		roleName: (aDict at: 'RoleName');
		createDate: (DateAndTime fromString: (aDict at: 'CreateDate'));
		arn: (aDict at: 'Arn');
		maxSessionDuration: (aDict at: 'MaxSessionDuration');
		path: (aDict at: 'Path').

	^ anInstance
]

{ #category : #accessing }
GtAwsIAMRole >> arn [
	^ arn
]

{ #category : #accessing }
GtAwsIAMRole >> arn: anObject [
	arn := anObject
]

{ #category : #accessing }
GtAwsIAMRole >> createDate [
	^ createDate
]

{ #category : #accessing }
GtAwsIAMRole >> createDate: anObject [
	createDate := anObject
]

{ #category : #accessing }
GtAwsIAMRole >> lookupInCloudFormation [
	^ self client cloudformation lookupObject: self roleName
]

{ #category : #accessing }
GtAwsIAMRole >> maxSessionDuration [
	^ maxSessionDuration
]

{ #category : #accessing }
GtAwsIAMRole >> maxSessionDuration: anObject [
	maxSessionDuration := anObject
]

{ #category : #accessing }
GtAwsIAMRole >> path [
	^ path
]

{ #category : #accessing }
GtAwsIAMRole >> path: anObject [
	path := anObject
]

{ #category : #accessing }
GtAwsIAMRole >> roleId [
	^ roleId
]

{ #category : #accessing }
GtAwsIAMRole >> roleId: anObject [
	roleId := anObject
]

{ #category : #accessing }
GtAwsIAMRole >> roleName [
	^ roleName
]

{ #category : #accessing }
GtAwsIAMRole >> roleName: anObject [
	roleName := anObject
]
