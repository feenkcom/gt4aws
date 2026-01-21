Class {
	#name : #GtAwsEfsFileSystem,
	#superclass : #GtAwsObject,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEfsFileSystem class >> fromDictionary: aDict [
	^ self new jsonObject: aDict
]
