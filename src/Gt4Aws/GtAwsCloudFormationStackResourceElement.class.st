Class {
	#name : #GtAwsCloudFormationStackResourceElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'resource',
		'label',
		'name'
	],
	#category : #'Gt4Aws-Elements'
}

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> initialize [
	super initialize.

	self fitContent.
	self padding: (BlInsets all: 5).

	self initializeLabel.
	self initializeName.

	self addChild: self label as: #label.
	self addChild: self name as: #name
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> initializeBorder [
	self
		border: (BlBorder paint: (GtAwsStatus forName: self resource status) foregroundColor width: 3)
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> initializeLabel [
	label := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
					foreground: BrGlamorousColors disabledHeaderTextColor)
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> initializeName [
	name := BrLabel new aptitude: BrGlamorousLabelAptitude new
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> label [
	^ label
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> label: anObject [
	label := anObject
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> name [
	^ name
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> onResourceUpdated [
	self initializeBorder.

	self updateLabel.
	self updateName.
	self updateClickHandler
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> resource [
	^ resource
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> resource: anObject [
	resource := anObject.
	
	self onResourceUpdated
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> updateClickHandler [
	self
		when: BlClickEvent
		do: [ :anEvent | anEvent target phlow spawnObject: self resource ]
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> updateLabel [
	self label text: self resource resourceType
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> updateName [
	self name
		text: (String
				printStringLimitedTo: 50
				using: [ :s | s nextPutAll: self resource physicalResourceId ])
]
