Class {
	#name : #GtAwsCliFlag,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #'as yet unclassified' }
GtAwsCliFlag >> asCli [
	^ {'--' , self name}
]

{ #category : #'as yet unclassified' }
GtAwsCliFlag >> gtCliFor: aView [
	<gtView>
	^ aView textEditor
		title: 'CLI';
		priority: 1;
		text: [ ' ' join: self asCli ]
]

{ #category : #accessing }
GtAwsCliFlag >> name [
	^ name
]

{ #category : #accessing }
GtAwsCliFlag >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCliFlag >> printOn: aStream [
	aStream nextPutAll: (' ' join: self asCli)
]
