Class {
	#name : #GtAwsYellowStatus,
	#superclass : #GtAwsStatus,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsYellowStatus class >> possibleNames [
	^ #('DELETE_SKIPPED' 'CREATE_SKIPPED')
]

{ #category : #accessing }
GtAwsYellowStatus >> foregroundColor [
	^ BrGlamorousColors failureBackgroundColor
]
