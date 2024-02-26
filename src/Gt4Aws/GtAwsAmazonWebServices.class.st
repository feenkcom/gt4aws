Class {
	#name : #GtAwsAmazonWebServices,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'awsRegion',
		'instanceTypes',
		'retryCount'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Gt4Aws-Client'
}

{ #category : #accessing }
GtAwsAmazonWebServices class >> awsExecutable [

	^ OSPlatform current isWindows
		ifTrue: [ 'aws.exe' ]
		ifFalse: [ '/usr/local/bin/aws' ].
]

{ #category : #testing }
GtAwsAmazonWebServices class >> cleanUniqueInstance [
	uniqueInstance := nil.
]

{ #category : #accessing }
GtAwsAmazonWebServices class >> default [
	^ self uniqueInstance
]

{ #category : #testing }
GtAwsAmazonWebServices class >> hasUniqueInstance [

	^ uniqueInstance notNil
]

{ #category : #accessing }
GtAwsAmazonWebServices class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #private }
GtAwsAmazonWebServices >> autoScalingGroupDescriptionFor: groupName [
	"Answer the full description of the specified auto-scaling group"

	^ self runArguments: (Array
				with: 'autoscaling'
				with: 'describe-auto-scaling-groups'
				with: '--auto-scaling-group-name'
				with: groupName)
		returnBlock: [ :proc | STONJSON fromString: proc stdout ]
		retryCount: retryCount.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> autoScalingGroupRunningCountIn: groupName [
	"Answer the number of machines currently running in the specified group"

	^ self runArguments: (Array
				with: 'autoscaling'
				with: 'describe-auto-scaling-instances'
				with: '--query'
				with: 'length(AutoScalingInstances[?AutoScalingGroupName==''', groupName, '''])')
		returnBlock: [ :proc | proc stdout asIntegerNumber ]
		retryCount: retryCount.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> autoScalingGroupScheduledActionsCountIn: groupName [
	"Answer the number of machines currently running in the specified group"

	^ self runArguments: (Array
				with: 'autoscaling'
				with: 'describe-scheduled-actions'
				with: '--auto-scaling-group-name'
				with: groupName
				with: '--query'
				with: 'length(ScheduledUpdateGroupActions)')
		returnBlock: [ :proc | proc stdout asIntegerNumber ]
		retryCount: retryCount.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> autoscalingGroup: groupName createOrUpdateTagAt: keyString put: valueString [

	keyString size > 128 ifTrue:
		[ self error: 'AWS Tag keys must be <= 128 unicode characters' ].
	valueString size > 256 ifTrue:
		[ self error: 'AWS Tag values must be <= 256 unicode characters' ].
	self runArguments: (Array
			with: 'autoscaling'
			with: 'create-or-update-tags'
			with: '--tags'
			with: 'ResourceId=', groupName, 
				',ResourceType=auto-scaling-group,Key=', keyString,
				',Value=', valueString,
				',PropagateAtLaunch=true')
		returnBlock: nil
		retryCount: retryCount.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> autoscalingGroup: groupName setDesiredCapacity: desiredSize min: minSize max: maxSize [

	self runArguments: {
				'autoscaling'.
				'update-auto-scaling-group'.
				'--auto-scaling-group-name'.
				groupName.
				'--min-size'.
				minSize displayString.
				'--max-size'.
				maxSize displayString.
				'--desired-capacity'.
				desiredSize displayString.
				}
		returnBlock: nil
		retryCount: retryCount.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> autoscalingGroup: groupName setTimelimit: timeoutTime [
	"Set the timeout for the specified group.
	timeoutTime is an ISO8601 format string."

	self runArguments: {
				'autoscaling'.
				'put-scheduled-update-group-action'.
				'--auto-scaling-group-name'.
				groupName.
				'--scheduled-action-name'.
				'set-time-limit-for-workers'.
				'--start-time'.
				timeoutTime.
				'--min-size'.
				'0'.
				'--max-size'.
				'0'.
				'--desired-capacity'.
				'0'.
				}
		returnBlock: nil
		retryCount: retryCount.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> awsExecutable [

	^ self class awsExecutable
]

{ #category : #accessing }
GtAwsAmazonWebServices >> awsRegion [

	^ awsRegion
]

{ #category : #accessing }
GtAwsAmazonWebServices >> awsRegion: aString [

	awsRegion := aString.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> cloudformationListStackResourcesFor: aStackId [
	| proc |
	proc := GtSubprocessWithInMemoryOutput
			command: self awsExecutable
			arguments: {'cloudformation'.
					'list-stack-resources'.
					'--stack-name'.
					aStackId}.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
	^ ((STONJSON fromString: proc stdout) at: 'StackResourceSummaries')
		collect: [ :aDict | (S3CloudformationStackResource fromDictionary: aDict) client: self ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> cloudformationListStacks [
	| proc |
	proc := GtSubprocessWithInMemoryOutput
			command: self awsExecutable
			arguments: {'cloudformation'.
					'list-stacks'}.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
	^ ((STONJSON fromString: proc stdout) at: 'StackSummaries')
		collect: [ :aDict | (S3CloudformationStack fromDictionary: aDict) client: self ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> deleteAllInS3Url: s3Url [
	"Remove all the entries in the specified S3 bucket"
	| arguments proc |

	arguments := Array
		with: 's3'
		with: 'rm'
		with: s3Url
		with: '--recursive'
		with: '--exclude'
		with: ''.
	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: arguments.
	proc
		addAllEnvVariablesFromParentWithoutOverride;
		environmentAt: 'AWS_REGION' put: self awsRegion;
		retryCount: retryCount;
		setDefaultErrorBlock.
	
	monitor critical: [ 
		self emitAwsCommandStartedSignalWithArguments: arguments.
		[ proc runAndWait ] ensure: [
			self emitAwsCommandEndedSignal  ] ].
]

{ #category : #accessing }
GtAwsAmazonWebServices >> ec2Command: operation instanceId: instanceId notification: aString [
	"Perform the specified operation on the instanceId and notify the user.
	This requires a different AWS user profile than other operations.  Set up the profile prior to starting the machine, and then delete it after."
	| result |

	monitor critical:
		[ 
		result := self primEc2Command: operation instanceId: instanceId.
		"(FileLocator home / '.aws') resolve deleteAll" ].
	"Notify the user that the runner has been started, but give GtWorld a chance to open first during image startup"
	aString ifNotNil:
		[ [ GtWorld allInstancesDo: [ :world |
			world inform: aString ] ]
			forkAt: Processor userSchedulingPriority ].
	^ result
]

{ #category : #accessing }
GtAwsAmazonWebServices >> ec2CreateTags: aCollectionOfAssociations instanceId: aString [
	| args proc |

	self assert: aCollectionOfAssociations notEmpty
		description: 'There must be at least one tag defined'.
	args := Array streamContents: [ :stream |
		stream
			nextPut: 'ec2';
			nextPut: 'create-tags';
			nextPut: '--resources';
			nextPut: aString;
			nextPut: '--tags'.
		aCollectionOfAssociations do: [ :assoc |
			stream nextPut: 'Key=', assoc key, ',Value=', assoc value ] ].
	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: args.
	proc 
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
]

{ #category : #logging }
GtAwsAmazonWebServices >> emitAwsCommandEndedSignal [
	(GtAwsWebServiceCommandEndSignal new) emit
]

{ #category : #logging }
GtAwsAmazonWebServices >> emitAwsCommandStartedSignalWithArguments: anArray [ 
	(GtAwsWebServiceCommandStartSignal new 
		arguments: anArray;
		retryCount: retryCount;
		executableName: self awsExecutable) emit
]

{ #category : #accessing }
GtAwsAmazonWebServices >> getInstanceNameOf: instanceId [
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
			'ec2'.
			'describe-instances'.
			'--instance-id'.
			instanceId.
			'--query'.
			'Reservations[*].Instances[*].Tags[?Key==''Name''].Value'.
			'--output'.
			'text'.
			}.
	proc
		retryCount: retryCount; 
		addAllEnvVariablesFromParentWithoutOverride.
	monitor critical: [ proc runAndWait ].
	proc isSuccess ifFalse: [ ^ nil ].
	^ proc stdout trimBoth.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> getParameterNamed: nameString [
	|  proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: (Array
				with: 'ssm'
				with: 'get-parameter'
				with: '--name'
				with: nameString
				with: '--query'
				with: 'Parameter.Value'
				with: '--output'
				with: 'text').
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
	^ proc stdout trimAll.

]

{ #category : #accessing }
GtAwsAmazonWebServices >> initialize [

	super initialize.
	monitor := Mutex new.
	awsRegion := 'us-east-1'.
	retryCount := 3.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> instanceTypes [
	"Answer a collection of the available instance types."
	instanceTypes ifNotNil: [^instanceTypes].
	^self
		runArguments: {'ec2'. 'describe-instance-types'.}
		returnBlock: 
			[:proc |
			| typesArray |
			typesArray := (STONJSON fromString: proc stdout trimBoth)
						at: #InstanceTypes.
			instanceTypes := Dictionary new.
			typesArray do: 
					[:each |
					instanceTypes at: (each at: #InstanceType)
						put: (GtAwsInstanceType jsonObject: each)].
			instanceTypes]
		retryCount: retryCount
]

{ #category : #accessing }
GtAwsAmazonWebServices >> primEc2Command: operation instanceId: aString [
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
			'ec2'.
			operation.
			'--instance-ids'.
			aString.
			}.
	proc 
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].

	^ proc stdout trimBoth.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> putParameterNamed: nameString value: valueString [
	|  proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
			'ssm'.
			'put-parameter'.
			'--overwrite'.
			'--type'.
			'StringList'.
			'--name'.
			nameString.
			'--value'.
			valueString.
			}.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
	^ proc stdout trimAll.

]

{ #category : #accessing }
GtAwsAmazonWebServices >> retryCount [
	^ retryCount
]

{ #category : #accessing }
GtAwsAmazonWebServices >> retryCount: anInteger [
	retryCount := anInteger
]

{ #category : #private }
GtAwsAmazonWebServices >> runArguments: anArray returnBlock: aBlockOrNil [
	"Run the aws cli with the supplied arguments and process stdout with aBlock"
	| proc |
	
	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: anArray.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ 
		self emitAwsCommandStartedSignalWithArguments: anArray.
		[ proc runAndWait ] ensure: [
			self emitAwsCommandEndedSignal  ] ].
	
	^ (aBlockOrNil ifNil: [ [ :p | p ] ]) value: proc 
]

{ #category : #accessing }
GtAwsAmazonWebServices >> runArguments: anArray returnBlock: aBlockOrNil retryCount: retryNumber [
	| retriesLeft |

	retriesLeft := retryNumber.
	^ [ retriesLeft := retriesLeft - 1.
		self runArguments: anArray returnBlock: aBlockOrNil ]
			on: Error
			do: [ :ex | retriesLeft > 0 
				ifTrue: [ ex retry ]
				ifFalse: [ ex pass ] ].
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3Cp: srcString to: dstString [
	"Copy srcString to dstString.
	One must be in the format of a s3 URL, i.e. s3://path/to/file.
	The other must be a local file."
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
				's3'.
				'cp'.
				srcString.
				dstString.
				}.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3DownloadDir: s3DirString to: aFileReference [
	"Download all files in the supplied s3 bucket to aFileReference.
	Directories are ignored (this isn't recursive)."
	| s3Files |

	self assert: aFileReference isDirectory.
	s3Files := self s3ls: s3DirString.
	s3Files 
		select: [ :fileData | fileData isFile ]
		thenDo: [ :fileData |
			self s3Cp: s3DirString, fileData basename to: (aFileReference / fileData basename) fullName ].
	^ aFileReference.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3Ls [
	| proc |
	proc := GtSubprocessWithInMemoryOutput
			command: self awsExecutable
			arguments: {'s3'.
					'ls'}.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
	^ proc stdout lines
		collect: [ :aLine | 
			| words |
			words := Character space split: aLine.
			GtAwsS3Bucket new
				modifiedAt: (DateAndTime fromString: words first , ' ' , words second);
				name: words third ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3MakeBucket: aString [
	"Create the specified bucket.
	aString must be in the format of a s3 URL, i.e. s3://path/to/dir."
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
				's3'.
				'mb'.
				aString.
				}.
	proc
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3ls: aString [
	"Answer the contents of the supplied S3 bucket.
	aString must be in the format of a s3 URL, i.e. s3://path/to/dir.
	For now answer { file name string. file size string. file date string. }
	Directories have a trailing slash (/), 0 size and nil date."
	| proc lsString files fileRx directoryRx |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
				's3'.
				'ls'.
				aString.
				}.
	proc
		retryCount: retryCount;
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
	
	lsString := proc stdout trimBoth.
	fileRx := '([0-9\-]+ [0-9:]+) +(\d+) +(.+)' asRegex.
	directoryRx := ' *PRE (.+)' asRegex.
	files := Array streamContents: [ :stream |
	lsString linesDo: [ :each | | search |
		search := fileRx search: each.
		search ifTrue:
			[ stream nextPut: (GtAwsS3FileReference new
				s3DirectoryUrl: aString;
				basename: (fileRx subexpressions: 4) first;
				size: (fileRx subexpressions: 3) first asNumber;
				modificationTime: (fileRx subexpressions: 2) first) ].
		search := directoryRx search: each.
		search ifTrue:
			[ stream nextPut: (GtAwsS3FileReference new
				s3DirectoryUrl: aString;
				basename: (directoryRx subexpressions: 2) first;
				size: 0) ] ] ].
	^ files.
]

{ #category : #accessing }
GtAwsAmazonWebServices >> setAccessKeyId: aString [
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
			'configure'.
			'set'.
			'aws_access_key_id'.
			aString.
			}.
	proc 
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
]

{ #category : #accessing }
GtAwsAmazonWebServices >> setRegion: aString [
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
			'configure'.
			'set'.
			'region'.
			aString.
			}.
	proc 
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
]

{ #category : #accessing }
GtAwsAmazonWebServices >> setSecretAccessKey: aString [
	| proc |

	proc := GtSubprocessWithInMemoryOutput
		command: self awsExecutable
		arguments: {
			'configure'.
			'set'.
			'aws_secret_access_key'.
			aString.
			}.
	proc 
		addAllEnvVariablesFromParentWithoutOverride;
		setDefaultErrorBlock.
	monitor critical: [ proc runAndWait ].
]
