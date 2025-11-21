Class {
	#name : #GtAwsShape,
	#superclass : #Object,
	#instVars : [
		'service',
		'rawData',
		'name',
		'members'
	],
	#category : 'Gt4Aws-Importer'
}

{ #category : #'as yet unclassified' }
GtAwsShape >> documentation [
	^ self rawData at: 'documentation' ifAbsent: [ '' ]
]

{ #category : #'as yet unclassified' }
GtAwsShape >> gtDocumentationFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Documentation';
		priority: 8;
		text: [ self documentation ]
]

{ #category : #'as yet unclassified' }
GtAwsShape >> gtMembersFor: aView [
	<gtView>
	self isStructure ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Members';
		priority: 1;
		items: [ self members associations ];
		children: [ :aPair | aPair value members associations ];
		column: 'Name' text: #key;
		column: 'Type' text: [ :aPair | aPair value type ];
		column: 'Documentation' text: [ :aPair | aPair value documentation ];
		send: #value
]

{ #category : #'as yet unclassified' }
GtAwsShape >> gtRawDataFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw data';
		priority: 10;
		object: [ self rawData ];
		view: #gtLiveFor:
]

{ #category : #'as yet unclassified' }
GtAwsShape >> initialize [
	super initialize.
	
	self members: Dictionary new
]

{ #category : #'as yet unclassified' }
GtAwsShape >> isError [
	^ self rawData includesKey: 'error'
]

{ #category : #'as yet unclassified' }
GtAwsShape >> isList [
	^ self type = 'list'
]

{ #category : #'as yet unclassified' }
GtAwsShape >> isStructure [
	^ self type = 'structure'
]

{ #category : #accessing }
GtAwsShape >> members [
	^ members
]

{ #category : #accessing }
GtAwsShape >> members: anObject [
	members := anObject
]

{ #category : #accessing }
GtAwsShape >> name [
	^ name
]

{ #category : #accessing }
GtAwsShape >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
GtAwsShape >> onRawDataSupplied [
	self isStructure
		ifTrue: [ self
				members: ((self rawData at: 'members') associations
						collect: [ :aPair | aPair key -> (self service shapeAt: (aPair value at: 'shape')) ])
						asDictionary ].

	self isList
		ifTrue: [ self
				members: {'member' -> (self service shapeAt: (self rawData at: 'member' at: 'shape'))}
						asDictionary ]
]

{ #category : #'as yet unclassified' }
GtAwsShape >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtAwsShape >> rawData [
	^ rawData
]

{ #category : #accessing }
GtAwsShape >> rawData: anObject [
	rawData := anObject.

	self onRawDataSupplied
]

{ #category : #accessing }
GtAwsShape >> service [
	^ service
]

{ #category : #accessing }
GtAwsShape >> service: anObject [
	service := anObject
]

{ #category : #'as yet unclassified' }
GtAwsShape >> type [
	^ self rawData at: 'type'
]
