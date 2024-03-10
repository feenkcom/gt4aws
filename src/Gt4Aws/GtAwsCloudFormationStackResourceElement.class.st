Class {
	#name : #GtAwsCloudFormationStackResourceElement,
	#superclass : #BrFrame,
	#instVars : [
		'resource',
		'label'
	],
	#category : #'Gt4Aws-Elements'
}

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> initialize [
	super initialize.

	self fitContent.
	self padding: (BlInsets all: 5).

	self initializeLabel.

	self addChild: self label as: #label
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> initializeBorder [
	self
		border: (BlBorder paint: (GtAwsStatus forName: self resource status) foregroundColor width: 3)
]

{ #category : #accessing }
GtAwsCloudFormationStackResourceElement >> initializeLabel [
	label := BrLabel new aptitude: BrGlamorousLabelAptitude
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
GtAwsCloudFormationStackResourceElement >> onResourceUpdated [
	self initializeBorder.

	self updateLabel
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
GtAwsCloudFormationStackResourceElement >> updateLabel [
	self label
		text: self resource resourceType , ' (' , self resource logicalResourceId , ')'
]
