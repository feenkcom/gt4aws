Class {
	#name : #GtAwsCliFlag,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : 'Gt4Aws-Executor'
}

{ #category : #converting }
GtAwsCliFlag >> asAwsCli [
	^ {'--' , self name}
]

{ #category : #u }
GtAwsCliFlag >> gtCliFor: aView [
	<gtView>
	^ aView textEditor
		title: 'CLI';
		priority: 1;
		text: [ ' ' join: self asAwsCli ]
]

{ #category : #accessing }
GtAwsCliFlag >> name [
	^ name
]

{ #category : #accessing }
GtAwsCliFlag >> name: anObject [
	name := anObject
]

{ #category : #printing }
GtAwsCliFlag >> printOn: aStream [
	aStream nextPutAll: (' ' join: self asAwsCli)
]
