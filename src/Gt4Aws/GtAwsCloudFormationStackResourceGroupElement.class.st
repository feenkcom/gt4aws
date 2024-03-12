Class {
	#name : #GtAwsCloudFormationStackResourceGroupElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'label',
		'grid',
		'resourceGroup'
	],
	#category : #'Gt4Aws-Elements'
}

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> grid [
	^ grid
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> grid: anObject [
	grid := anObject
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> initialize [
	super initialize.

	self fitContent.
	self background: Color veryVeryLightGray.

	self initializeLabel.
	self initializeGrid.

	self addChild: self label as: #label.
	self addChild: self grid as: #grid
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> initializeGrid [
	grid := BrHorizontalGrid new fitContent columnCount: 2
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> initializeLabel [
	label := BrLabel new aptitude: BrGlamorousLabelAptitude
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> label [
	^ label
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> onResourceGroupUpdated [
	self label text: self resourceGroup first resourceTypeGroup.

	self grid removeChildren.

	self resourceGroup
		do: [ :aResource | 
			self grid
				addChild: (GtAwsCloudFormationStackResourceElement new
						resource: aResource;
						margin: (BlInsets
								top: 5
								bottom: 5
								left: 0
								right: 5)) ].

	self
		when: BlClickEvent
		do: [ :anEvent | anEvent target phlow spawnObject: self resourceGroup ]
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> resourceGroup [
	^ resourceGroup
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceGroupElement >> resourceGroup: anObject [
	resourceGroup := anObject.
	
	self onResourceGroupUpdated
]
