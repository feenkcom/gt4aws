Class {
	#name : #GtAwsCliArgument,
	#superclass : #Object,
	#instVars : [
		'key',
		'value'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #'as yet unclassified' }
GtAwsCliArgument >> asCli [
	^ {'--', self key. self value}
]

{ #category : #'as yet unclassified' }
GtAwsCliArgument >> gtCliFor: aView [
	<gtView>
	^ aView textEditor
		title: 'CLI';
		priority: 1;
		text: [ ' ' join: self asCli ]
]

{ #category : #accessing }
GtAwsCliArgument >> key [
	^ key
]

{ #category : #accessing }
GtAwsCliArgument >> key: anObject [
	key := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCliArgument >> printOn: aStream [
	aStream nextPutAll: (' ' join: self asCli)
]

{ #category : #accessing }
GtAwsCliArgument >> value [
	^ value
]

{ #category : #accessing }
GtAwsCliArgument >> value: anObject [
	value := anObject
]