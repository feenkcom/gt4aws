Class {
	#name : #GtAwsCommand,
	#superclass : #Object,
	#instVars : [
		'arguments'
	],
	#category : #'Gt4Aws-Commands'
}

{ #category : #accessing }
GtAwsCommand >> arguments [

	^ arguments
]

{ #category : #accessing }
GtAwsCommand >> client [

	^ GtAwsClient new
]

{ #category : #execution }
GtAwsCommand >> execute [

	^ self process:
		(self client run: arguments)
]

{ #category : #initialization }
GtAwsCommand >> initialize [

	super initialize.
	arguments := GtAwsCliArguments new.
]

{ #category : #private }
GtAwsCommand >> process: aResult [

	^ aResult
]

{ #category : #'global options' }
GtAwsCommand >> profile: aString [

	arguments add: (GtAwsCliArgument new
		key: 'profile';
		value: aString)
]

{ #category : #'global options' }
GtAwsCommand >> region: aString [

	arguments add: (GtAwsCliArgument new
		key: 'region';
		value: aString)
]
