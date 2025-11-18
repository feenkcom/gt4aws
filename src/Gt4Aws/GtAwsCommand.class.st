Class {
	#name : #GtAwsCommand,
	#superclass : #Object,
	#instVars : [
		'arguments',
		'retryCount',
		'awsClient'
	],
	#category : #'Gt4Aws-Commands'
}

{ #category : #accessing }
GtAwsCommand >> arguments [

	^ arguments
]

{ #category : #accessing }
GtAwsCommand >> client [

	^ awsClient
]

{ #category : #execution }
GtAwsCommand >> execute [

	awsClient := GtAwsClient new.
	^ self process: (awsClient run: arguments)
]

{ #category : #execution }
GtAwsCommand >> executeWithStonRetry [
	"Execute the receiver.
	AWS commands sometimes truncate the output, resulting in a STON parsing error.  Retry in these cases."
	| retryDelay awsClients |

	retryDelay := 1.
	awsClients := #().
	^ [ self execute ]
		on: STONReaderError
		do: [ :ex |
			awsClients := awsClients copyWith: awsClient -> ex.
			retryCount := retryCount - 1.
			retryCount > 0 ifTrue: 
				[ retryDelay <= 16 ifTrue:
					[ retryDelay := retryDelay * 2 ].
				retryDelay seconds wait. 
				ex retry ]
			ifFalse: 
				[ ex pass ] ].
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

{ #category : #accessing }
GtAwsCommand >> retryCount: anInteger [ 
	self 
		assert: [ anInteger >= 0 ]
		description: 'Cannot set a negative retry count'.
		
	retryCount := anInteger 
]
