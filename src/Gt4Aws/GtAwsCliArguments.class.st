Class {
	#name : #GtAwsCliArguments,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#instVars : [
		'operation',
		'endpointPrefix'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #'as yet unclassified' }
GtAwsCliArguments >> asAwsCli [
	^ {self endpointPrefix.
		self operation} , (self items flatCollect: #asAwsCli)
]

{ #category : #accessing }
GtAwsCliArguments >> endpointPrefix [
	^ endpointPrefix
]

{ #category : #accessing }
GtAwsCliArguments >> endpointPrefix: anObject [
	endpointPrefix := anObject
]

{ #category : #'as yet unclassified' }
GtAwsCliArguments >> gtArgumentsFor: aView [
	<gtView>
	^ aView list
		title: 'Arguments';
		priority: 2;
		items: [ self items ]
]

{ #category : #'as yet unclassified' }
GtAwsCliArguments >> gtCliFor: aView [
	<gtView>
	^ aView textEditor
		title: 'CLI';
		priority: 1;
		text: [ ' ' join: self asAwsCli ]
]

{ #category : #accessing }
GtAwsCliArguments >> operation [
	^ operation
]

{ #category : #accessing }
GtAwsCliArguments >> operation: anObject [
	operation := anObject
]
