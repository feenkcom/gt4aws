Class {
	#name : #GtAwsLambda,
	#superclass : #Object,
	#instVars : [
		'client',
		'functions'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsLambda >> client [
	^ client
]

{ #category : #accessing }
GtAwsLambda >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsLambda >> functions [
	^ functions ifNil: [ self refreshFunctions ]
]

{ #category : #accessing }
GtAwsLambda >> gtDisplayOn: stream [
	stream nextPutAll: 'AWS Lambda'
]

{ #category : #accessing }
GtAwsLambda >> gtFunctionsFor: aView [
	<gtView>
	^ aView forward
		title: 'Functions';
		priority: 1;
		object: [ self functions ];
		view: #gtFunctionsFor:
]

{ #category : #accessing }
GtAwsLambda >> gtRefreshFunctionsFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		tooltip: 'Refresh functions';
		icon: BrGlamorousVectorIcons refresh;
		action: [ self refreshFunctions ]
]

{ #category : #accessing }
GtAwsLambda >> gtSearchFunctionsFor: aSearch [
	<gtSearch>
		^ aSearch list
		title: 'Functions';
		priority: 30;
		items: [ self functions ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
]

{ #category : #accessing }
GtAwsLambda >> refreshFunctions [
	^ functions := self client lambdaListFunctions
]
