Class {
	#name : #GtAwsStatus,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #'instance creation' }
GtAwsStatus class >> forName: aName [
	| anUppercase |
	anUppercase := aName asUppercase.
	self
		allSubclassesDo: [ :aClass | 
			(aClass possibleNames includes: anUppercase)
				ifTrue: [ ^ aClass new name: aName ] ].

	^ GtAwsNormalStatus new name: aName
]

{ #category : #accessing }
GtAwsStatus class >> possibleNames [
	^ #()
]

{ #category : #accessing }
GtAwsStatus >> foregroundColor [
	^ Color black
]

{ #category : #accessing }
GtAwsStatus >> label [
	^ (self name ifNil: [ '' ]) asRopedText foreground: self foregroundColor
]

{ #category : #accessing }
GtAwsStatus >> name [
	^ name
]

{ #category : #accessing }
GtAwsStatus >> name: anObject [
	name := anObject
]
