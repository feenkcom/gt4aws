Class {
	#name : #GtAwsRedStatus,
	#superclass : #GtAwsStatus,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsRedStatus class >> possibleNames [
	^ #('ROLLBACK_COMPLETE' 'DELETE_FAILED' 'UPDATE_ROLLBACK_COMPLETE')
]

{ #category : #accessing }
GtAwsRedStatus >> foregroundColor [
	^ BrGlamorousColors errorBackgroundColor
]
