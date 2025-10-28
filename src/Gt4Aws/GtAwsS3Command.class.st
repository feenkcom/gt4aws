Class {
	#name : #GtAwsS3Command,
	#superclass : #GtAwsCommand,
	#instVars : [
		'key'
	],
	#category : 'Gt4Aws-Commands'
}

{ #category : #initialization }
GtAwsS3Command >> initialize [

	super initialize.
	arguments endpointPrefix: 's3'.
]
