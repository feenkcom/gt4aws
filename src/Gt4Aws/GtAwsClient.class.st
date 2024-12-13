Class {
	#name : #GtAwsClient,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'awsExecutable',
		'retryCount',
		'defaultRegion',
		'defaultProfile'
	],
	#category : #'Gt4Aws-Client'
}

{ #category : #accessing }
GtAwsClient >> awsExecutable [
	^ awsExecutable
]

{ #category : #accessing }
GtAwsClient >> awsExecutable: anObject [
	awsExecutable := anObject
]

{ #category : #'as yet unclassified' }
GtAwsClient >> defaultAwsExecutable [
	^ OSPlatform current isWindows
		ifTrue: [ 'aws.exe' ]
		ifFalse: [ '/usr/local/bin/aws' ]
]

{ #category : #accessing }
GtAwsClient >> defaultProfile [
	^ defaultProfile
]

{ #category : #accessing }
GtAwsClient >> defaultProfile: anObject [
	defaultProfile := anObject
]

{ #category : #accessing }
GtAwsClient >> defaultRegion [
	^ defaultRegion
]

{ #category : #accessing }
GtAwsClient >> defaultRegion: anObject [
	defaultRegion := anObject
]

{ #category : #'as yet unclassified' }
GtAwsClient >> defaultRetryCount [
	^ 3
]

{ #category : #'as yet unclassified' }
GtAwsClient >> emitAwsCommandEndedSignal [
	(GtAwsWebServiceCommandEndSignal new) emit
]

{ #category : #'as yet unclassified' }
GtAwsClient >> emitAwsCommandStartedSignalWithArguments: anArray [
	(GtAwsWebServiceCommandStartSignal new
		arguments: anArray;
		retryCount: retryCount;
		executableName: self awsExecutable) emit
]

{ #category : #'as yet unclassified' }
GtAwsClient >> initialize [
	super initialize.
	
	monitor := Mutex new.
	awsExecutable := self defaultAwsExecutable.
	retryCount := self defaultRetryCount
]

{ #category : #accessing }
GtAwsClient >> retryCount [
	^ retryCount
]

{ #category : #accessing }
GtAwsClient >> retryCount: anObject [
	retryCount := anObject
]

{ #category : #'as yet unclassified' }
GtAwsClient >> run: arguments [
	^ self runArguments: arguments returnBlock: #stdout
]

{ #category : #'as yet unclassified' }
GtAwsClient >> runArguments: anArray returnBlock: aBlockOrNil [
	| proc |
	proc := GtSubprocessWithInMemoryOutput
			command: self awsExecutable
			arguments: anArray asAwsCli.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.

	self defaultRegion
		ifNotNil: [ :aRegion | proc environmentAt: 'AWS_REGION' put: aRegion ].

	self defaultProfile
		ifNotNil: [ :aProfile | proc environmentAt: 'AWS_PROFILE' put: aProfile ].

	monitor
		critical: [ self emitAwsCommandStartedSignalWithArguments: anArray.
			[ proc runAndWait ] ensure: [ self emitAwsCommandEndedSignal ] ].

	^ (aBlockOrNil ifNil: [ [ :p | p ] ]) value: proc
]
