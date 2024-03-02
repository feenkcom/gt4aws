Class {
	#name : #GtAwsEfs,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEfs >> client [
	^ client
]

{ #category : #accessing }
GtAwsEfs >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsEfs >> filesystems [
	^ self client efsListFileSystems
]

{ #category : #accessing }
GtAwsEfs >> gtListFileSystemsFor: aView [
	<gtView>
	^ aView list
		title: 'File systems';
		priority: 1;
		items: [ self filesystems ]
]

{ #category : #accessing }
GtAwsEfs >> printOn: aStream [
	^ aStream nextPutAll: 'AWS Elastic File System'
]
