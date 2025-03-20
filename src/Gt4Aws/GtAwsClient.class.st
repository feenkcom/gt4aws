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
	#category : #'Gt4Aws-Client'
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
	"Run the aws command arguments and pass the result to aBlockOrNil"
	| builder proc status stdout stderr output |

	builder := (GtExternalProcessBuilder new)
		command: self awsExecutable;
		arguments: anArray asAwsCli;
		addAllEnvVariablesFromParentWithoutOverride;
		pipeStderr;
		pipeStdout.
	self defaultRegion
		ifNotNil: [:aRegion | builder env: 'AWS_REGION' value: aRegion].
	self defaultProfile
		ifNotNil: [:aProfile | builder env: 'AWS_PROFILE' value: aProfile].
	monitor critical: 
		[self emitAwsCommandStartedSignalWithArguments: anArray.
		[| command stdoutStream stderrStream |
		"GtExternalProcess currently blocks if the output is large,
		e.g. when retrieving all instance types (around 6MB).
		For now, collect the output in a string."
		command := builder createNativeCommand.
		proc := command spawn.
		stdout := String new writeStream.
		stderr := String new writeStream.
		stdoutStream := proc stdoutStream do: [:ch | stdout nextPut: ch].
		stderrStream := proc stderrStream do: [:ch | stderr nextPut: ch].
		stdoutStream wait.
		stderrStream wait. ]
			ensure: [self emitAwsCommandEndedSignal]].
	status := proc wait.
	output := GtExternalProcessOutputHolder
		status: status
		stdout: stdout contents
		stderr: stderr contents.
	status isSuccess ifFalse: [self error: output stderr trimBoth ].
	^ (aBlockOrNil ifNil: [[:p | p]]) value: output.
]
