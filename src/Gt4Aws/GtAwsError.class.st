Class {
	#name : #GtAwsError,
	#superclass : #Error,
	#instVars : [
		'response'
	],
	#category : 'Gt4Aws-Client'
}

{ #category : #accessing }
GtAwsError >> messageText [
	^ (STONJSON fromString: self response contents) at: 'message'
]

{ #category : #accessing }
GtAwsError >> response [
	^ response
]

{ #category : #accessing }
GtAwsError >> response: anObject [
	response := anObject
]
