Class {
	#name : #GtAwsCliFlag,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #'as yet unclassified' }
GtAwsCliFlag >> asAwsCli [
	^ {'--' , self name}
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GtAwsCliFlag >> printOn: aStream [
	aStream nextPutAll: (' ' join: self asAwsCli)
]
