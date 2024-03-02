Class {
	#name : #GtAwsEksCluster,
	#superclass : #GtAwsObject,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEksCluster class >> fromDictionary: aDict [
	^ self new jsonObject: aDict
]
