Class {
	#name : #GtAwsGreenStatus,
	#superclass : #GtAwsStatus,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsGreenStatus class >> possibleNames [
	^ #('UPDATE_COMPLETE' 'CREATE_COMPLETE' 'DELETE_COMPLETE')
]

{ #category : #accessing }
GtAwsGreenStatus >> foregroundColor [
	^ BrGlamorousColors successBackgroundColor
]
