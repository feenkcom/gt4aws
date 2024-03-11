Class {
	#name : #GtAwsCloudFormationStackElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'stack',
		'label',
		'grid'
	],
	#category : #'Gt4Aws-Elements'
}

{ #category : #accessing }
GtAwsCloudFormationStackElement >> grid [
	^ grid
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> grid: anObject [
	grid := anObject
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> initialize [
	super initialize.
	
	self fitContent.
	self padding: (BlInsets all: 5).

	self initializeLabel.
	self initializeGrid.

	self addChild: self label as: #label.
	self addChild: self grid as: #grid
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> initializeBorder [
	self
		border: (BlBorder paint: (GtAwsStatus forName: self stack status) foregroundColor width: 3)
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> initializeGrid [
	grid := BrHorizontalGrid new fitContent columnCount: 2
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> initializeLabel [
	label := BrLabel new aptitude: BrGlamorousLabelAptitude
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> label [
	^ label
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> onStackUpdated [
	self initializeBorder.

	self updateLabel.
	self updateResources
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> stack [
	^ stack
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> stack: anObject [
	stack := anObject.
	
	self onStackUpdated.
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> updateLabel [
	self label text: self stack name
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> updateResources [
	self grid removeChildren.
	self stack resources
		do: [ :aResource | 
			self grid
				addChild: (GtAwsCloudFormationStackResourceElement new
						resource: aResource;
						margin: (BlInsets
								top: 5
								bottom: 5
								left: 0
								right: 5);
						when: BlClickEvent
							do: [ :anEvent | anEvent target phlow spawnObject: aResource ]) ]
]
