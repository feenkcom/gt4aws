Class {
	#name : #GtAwsEntityHolder,
	#superclass : #Object,
	#instVars : [
		'entities',
		'services',
		'mutex'
	],
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEntityHolder >> client [
	^ services
]

{ #category : #accessing }
GtAwsEntityHolder >> client: anObject [
	services := anObject
]

{ #category : #accessing }
GtAwsEntityHolder >> entities [
	^ entities ifNil: [ entities := self refreshEntities ]
]

{ #category : #accessing }
GtAwsEntityHolder >> entityId [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsEntityHolder >> entityName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsEntityHolder >> entitySearchKey [
	^ #name
]

{ #category : #accessing }
GtAwsEntityHolder >> findEntityWithId: anId [
	^ self entities
		detect: [ :anEntity | (anEntity perform: self entitySearchKey) = anId ]
		ifNone: [ nil ]
]

{ #category : #accessing }
GtAwsEntityHolder >> gtEntitiesFor: aView [
	<gtView>
	^ aView forward
		title: self entityName;
		priority: 3;
		object: [ self entities ];
		view: self viewName
]

{ #category : #accessing }
GtAwsEntityHolder >> gtRefreshFor: anAction [
	<gtAction>
	^ anAction button
		priority: 1;
		tooltip: 'Refresh ', self entityName;
		icon: BrGlamorousVectorIcons refresh;
		action: [ entities := self refreshEntities ]
]

{ #category : #accessing }
GtAwsEntityHolder >> gtSearchFunctionsFor: aSearch [
	<gtSearch>
		^ aSearch list
		title: self entityName;
		priority: 30;
		items: [ self entities ];
		itemsLimit: Float infinity;
		itemName: self entitySearchKey;
		filterBySubstring
]

{ #category : #'as yet unclassified' }
GtAwsEntityHolder >> initialize [

	super initialize.
	mutex := Mutex new.
]

{ #category : #accessing }
GtAwsEntityHolder >> printOn: aStream [
	aStream nextPutAll: self serviceName
]

{ #category : #accessing }
GtAwsEntityHolder >> refreshEntities [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsEntityHolder >> serviceName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsEntityHolder >> viewName [
	^ #gtLiveFor:
]
