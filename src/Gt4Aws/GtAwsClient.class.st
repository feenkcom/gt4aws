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
	#classVars : [
		'AwsExecutable'
	],
	#category : 'Gt4Aws-Client'
}

{ #category : #accessing }
GtAwsClient class >> awsExecutable [

	^ AwsExecutable ifNil: [ AwsExecutable := (GtOsSystemInfo current findExecutable: 'aws') fullName ]
]

{ #category : #initialization }
GtAwsClient class >> initialize [

	SessionManager default
		registerUserClassNamed: self name.
]

{ #category : #initialization }
GtAwsClient class >> reset [

	AwsExecutable := nil.
]

{ #category : #initialization }
GtAwsClient class >> shutDown: quitting [

	quitting ifTrue: [ self reset ]
]

{ #category : #initialization }
GtAwsClient class >> startUp: resuming [

	resuming ifTrue: [ self reset ]
]

{ #category : #accessing }
GtAwsClient >> awsExecutable [
	^ awsExecutable ifNil: [ self class awsExecutable ].
]

{ #category : #accessing }
GtAwsClient >> awsExecutable: anObject [
	awsExecutable := anObject
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
	^ 0
]

{ #category : #'as yet unclassified' }
GtAwsClient >> emitAwsCommandEndedSignalWithArguments: anArray [

	GtAwsWebServiceCommandEndSignal new
		arguments: anArray;
		retryCount: retryCount;
		executableName: self awsExecutable;
		emit
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

{ #category : #api }
GtAwsClient >> runArguments: anArray returnBlock: aBlockOrNil [
	| proc exception |

	proc := GtSubprocessWithInMemoryOutput command: self awsExecutable
				arguments: anArray asAwsCli.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		errorBlock: 
				[exception := proc pollException.
				exception ifNotNil: [exception freeze]].
	self defaultRegion
		ifNotNil: [:aRegion | proc environmentAt: 'AWS_REGION' put: aRegion].
	self defaultProfile
		ifNotNil: [:aProfile | proc environmentAt: 'AWS_PROFILE' put: aProfile].
	monitor critical: 
			[self emitAwsCommandStartedSignalWithArguments: anArray.
			[proc runAndWait]
				ensure: [self emitAwsCommandEndedSignalWithArguments: anArray]].
	exception ifNotNil: [self error: 'Exception while running command'].
	proc isSuccess ifFalse:
		[ self error: 'aws call completed unsuccessfully:', String cr, proc stderr asString ].
	^(aBlockOrNil ifNil: [[:p | p]]) value: proc
]
