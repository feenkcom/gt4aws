Class {
	#name : #GtAwsCommand,
	#superclass : #Object,
	#instVars : [
		'arguments',
		'retryCount'
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

{ #category : #execution }
GtAwsCommand >> executeWithStonRetry [
	"Execute the receiver.
	AWS commands sometimes truncate the output, resulting in a STON parsing error.  Retry in these cases."

	^ [ self execute ]
		on: STONReaderError
		do: [ :ex |
			retryCount := retryCount - 1.
			retryCount > 0
				ifTrue: [ 1 second wait. self execute ]
				ifFalse: [ ex pass ] ].
]

{ #category : #initialization }
GtAwsCommand >> initialize [

	super initialize.
	arguments := GtAwsCliArguments new.
	retryCount := 0.
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
