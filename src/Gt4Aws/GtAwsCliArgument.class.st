Class {
	#name : #GtAwsCliArgument,
	#superclass : #Object,
	#instVars : [
		'key',
		'value'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #'instance creation' }
GtAwsCliArgument class >> key: keyString value: valueString [

	^ self new
		key: keyString;
		value: valueString
]

{ #category : #converting }
GtAwsCliArgument >> asAwsCli [
	^ {'--', self key. self value}
]

{ #category : #ui }
GtAwsCliArgument >> gtCliFor: aView [
	<gtView>
	^ aView textEditor
		title: 'CLI';
		priority: 1;
		text: [ ' ' join: self asAwsCli ]
]

{ #category : #accessing }
GtAwsCliArgument >> key [
	^ key
]

{ #category : #accessing }
GtAwsCliArgument >> key: anObject [
	key := anObject
]

{ #category : #printing }
GtAwsCliArgument >> printOn: aStream [
	aStream nextPutAll: (' ' join: self asAwsCli)
]

{ #category : #accessing }
GtAwsCliArgument >> value [
	^ value
]

{ #category : #accessing }
GtAwsCliArgument >> value: anObject [
	value := anObject
]
