Class {
	#name : #GtAwsCliArguments,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'Gt4Aws-Executor'
}

{ #category : #'as yet unclassified' }
GtAwsCliArguments >> asCli [
	^ self items flatCollect: #asCli
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
		text: [ ' ' join: self asCli ]
]
