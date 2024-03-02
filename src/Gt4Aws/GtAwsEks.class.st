Class {
	#name : #GtAwsEks,
	#superclass : #Object,
	#instVars : [
		'client'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEks >> client [
	^ client
]

{ #category : #accessing }
GtAwsEks >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsEks >> clusters [
	^ self client eksListClusters
]

{ #category : #accessing }
GtAwsEks >> printOn: aStream [
	aStream nextPutAll: 'AWS Elastic Kubernetes Service'
]
