Class {
	#name : #GtAwsCloudFormationStackElement,
	#superclass : #BrHorizontalGrid,
	#instVars : [
		'stack',
		'label'
	],
	#category : #'Gt4Aws-Elements'
}

{ #category : #accessing }
GtAwsCloudFormationStackElement >> initialize [
	super initialize.

	self fitContent.
	self columnCount: 3.
	
	self padding: (BlInsets all: 5).

	self initializeLabel.

	self addChild: self label as: #label
]

{ #category : #accessing }
GtAwsCloudFormationStackElement >> initializeBorder [
	self
		border: (BlBorder paint: (GtAwsStatus forName: self stack status) foregroundColor width: 3)
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
	self stack resources
		do: [ :aResource | self addChild: (GtAwsCloudFormationStackResourceElement new resource: aResource) ]
]
