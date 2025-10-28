Class {
	#name : #GtAwsS3CopyCommand,
	#superclass : #GtAwsS3Command,
	#instVars : [
		'sourceArgument',
		'destinationArgument'
	],
	#category : 'Gt4Aws-Commands'
}

{ #category : #accessing }
GtAwsS3CopyCommand >> destination: dstUrl [

	destinationArgument := dstUrl
]

{ #category : #execution }
GtAwsS3CopyCommand >> execute [

	arguments
		add: sourceArgument;
		add: destinationArgument.
	^ super execute.
]

{ #category : #initialization }
GtAwsS3CopyCommand >> initialize [

	super initialize.
	arguments operation: 'cp'.
]

{ #category : #accessing }
GtAwsS3CopyCommand >> source: srcUrl [

	sourceArgument := srcUrl
]
