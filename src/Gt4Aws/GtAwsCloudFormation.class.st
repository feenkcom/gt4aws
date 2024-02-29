Class {
	#name : #GtAwsCloudFormation,
	#superclass : #Object,
	#instVars : [
		'client',
		'stacks'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCloudFormation >> client [
	<return: #GtAwsAmazonWebServices>
	^ client
]

{ #category : #accessing }
GtAwsCloudFormation >> client: anObject [
	client := anObject
]

{ #category : #printing }
GtAwsCloudFormation >> gtDisplayOn: stream [
	stream nextPutAll: 'AWS CloudFormation'
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> gtLatestStacksByStatusFor: aView [
	<gtView>
	client ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Latest stacks by status';
		priority: 3;
		items: [ self latestStacksByStatus associations ];
		column: 'Status' text: #key;
		column: '# of stacks' text: [:aPair | aPair value size ];
		send: #value
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> gtLatestStacksFor: aView [
	<gtView>
	client ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Latest stacks';
		priority: 3;
		object: [ self latestStacks ];
		view: #gtStacksFor:
]

{ #category : #accessing }
GtAwsCloudFormation >> gtRefreshStacksFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons refresh;
		tooltip: 'Refresh stacks';
		priority: 3;
		action: [ self refreshStacks ]
]

{ #category : #accessing }
GtAwsCloudFormation >> gtSearchStacksFor: aSearch [
	<gtSearch>
		^ aSearch list
		title: 'Stacks';
		priority: 30;
		items: [ self stacks ];
		itemsLimit: Float infinity;
		itemName: #name;
		filterBySubstring
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> gtStacksByStatusFor: aView [
	<gtView>
	client ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Stacks by status';
		priority: 2;
		items: [ self stacksByStatus associations ];
		column: 'Status' text: #key;
		column: '# of stacks' text: [:aPair | aPair value size ];
		send: #value
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> gtStacksFor: aView [
	<gtView>
	client ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stacks';
		priority: 1;
		object: [ self stacks ];
		view: #gtStacksFor:
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> latestStacks [
	^ GtAwsCloudformationStackGroup
		withAll: ((self stacks groupedBy: #name) values
				collect: [ :aList | aList detectMax: #lastTouched ])
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> latestStacksByStatus [
	^ self latestStacks groupedBy: #status
]

{ #category : #requests }
GtAwsCloudFormation >> refreshStacks [
	^ stacks := client cloudformationListStacks
]

{ #category : #requests }
GtAwsCloudFormation >> stacks [
	<return: #GtAwsCloudformationStackGroup>
	^ stacks ifNil: [ self refreshStacks ]
]

{ #category : #'gt - extensions' }
GtAwsCloudFormation >> stacksByStatus [
	^ self stacks groupedBy: #status
]
