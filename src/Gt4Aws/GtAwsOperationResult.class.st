Class {
	#name : #GtAwsOperationResult,
	#superclass : #Object,
	#instVars : [
		'result',
		'resultType',
		'types',
		'key',
		'documentation'
	],
	#category : #'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsOperationResult >> children [
	| aTypeDescription |
	aTypeDescription := self typeDescription.

	(aTypeDescription at: 'type') = 'list'
		ifTrue: [ ^ self result
				collect: [ :anEntity | 
					GtAwsOperationResult new
						result: anEntity;
						resultType: (aTypeDescription at: 'member' at: 'shape');
						types: self types ] ].

	(aTypeDescription at: 'type') = 'structure'
		ifTrue: [ ^ (aTypeDescription at: 'members') associations
				collect: [ :aPair | 
					GtAwsOperationResult new
						key: aPair key;
						result: (self result at: aPair key ifAbsent: [ nil ]);
						resultType: (aPair value at: 'shape');
						documentation: (aPair value at: 'documentation');
						types: self types ] ].

	^ {}
]

{ #category : #accessing }
GtAwsOperationResult >> documentation [
	^ documentation
]

{ #category : #accessing }
GtAwsOperationResult >> documentation: anObject [
	documentation := anObject
]

{ #category : #accessing }
GtAwsOperationResult >> gtDescriptionFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Description';
		priority: 1;
		items: [ {self} ];
		children: #children;
		column: 'Key' text: #key width: 150;
		column: 'Documentation' text: #documentation;
		column: 'Type' text: #resultType width: 180;
		expandUpTo: 2
]

{ #category : #accessing }
GtAwsOperationResult >> gtRawFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw';
		priority: 5;
		object: [ self result ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtAwsOperationResult >> initialize [
	super initialize.
	
	key := ''.
	documentation := ''
]

{ #category : #accessing }
GtAwsOperationResult >> key [
	^ key
]

{ #category : #accessing }
GtAwsOperationResult >> key: anObject [
	key := anObject
]

{ #category : #accessing }
GtAwsOperationResult >> result [
	^ result
]

{ #category : #accessing }
GtAwsOperationResult >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GtAwsOperationResult >> resultType [
	^ resultType
]

{ #category : #accessing }
GtAwsOperationResult >> resultType: anObject [
	resultType := anObject
]

{ #category : #accessing }
GtAwsOperationResult >> typeDescription [
	^ self types at: resultType
]

{ #category : #accessing }
GtAwsOperationResult >> types [
	^ types
]

{ #category : #accessing }
GtAwsOperationResult >> types: anObject [
	types := anObject
]
