Class {
	#name : #GtAwsAmazonWebServices,
	#superclass : #Object,
	#instVars : [
		'cloudformation',
		'entityHolders',
		'client'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Gt4Aws-Client'
}

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

{ #category : #'as yet unclassified' }
GtAwsAmazonWebServices >> awsRegion [
	^ self client
		run: {'configure'.
				'get'.
				'region'}
]

{ #category : #accessing }
GtAwsAmazonWebServices >> client [
	^ client
]

{ #category : #accessing }
GtAwsAmazonWebServices >> client: anObject [
	client := anObject
]

{ #category : #accessing }
GtAwsAmazonWebServices >> cloudWatchWeeklyCpuDataFor: anInstanceId [
	| endTime startTime output |
	endTime := DateAndTime now.
	startTime := endTime - 7 days.

	output := self client
			run: {'cloudwatch'.
					'get-metric-statistics'.
					'--namespace'.
					'AWS/EC2'.
					'--period'.
					'600'.
					'--start-time'.
					startTime asString.
					'--end-time'.
					endTime asString.
					'--metric-name'.
					'CPUUtilization'.
					'--statistics'.
					'Maximum'.
					'--dimensions'.
					'Name = InstanceId, Value = ' , anInstanceId}.

	^ GtAwsCloudWatchMaximumDataPointGroup
		withAll: ((((STONJSON fromString: output) at: 'Datapoints')
				collect: [ :aDict | (GtAwsCloudwatchMaximumDataPoint fromDictionary: aDict) client: self ])
				sorted: [ :a :b | a timestamp < b timestamp ])
]

{ #category : #cloudformation }
GtAwsAmazonWebServices >> cloudformation [
	"Model and provision all your cloud infrastructure"

	^ cloudformation
		ifNil: [ cloudformation := GtAwsCloudFormation new
					client: self;
					deployedResources;
					yourself ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> cloudformationListStackResourcesFor: aStackId [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'cloudformation';
					operation: 'list-stack-resources';
					add: (GtAwsCliArgument new
							key: 'stack-name';
							value: aStackId)).

	^ GtAwsCloudFormationStackResourceGroup
		withAll: (((STONJSON fromString: output) at: 'StackResourceSummaries')
				collect: [ :aDict | (GtAwsCloudformationStackResource fromDictionary: aDict) client: self ])
]

{ #category : #accessing }
GtAwsAmazonWebServices >> cloudformationListStacks [
	| output aCollection |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'cloudformation';
					operation: 'list-stacks').

	aCollection := ((STONJSON fromString: output) at: 'StackSummaries')
			collect: [ :aDict | (GtAwsCloudformationStack fromDictionary: aDict) client: self ].

	^ GtAwsCloudformationStackGroup withAll: aCollection
]

{ #category : #'as yet unclassified' }
GtAwsAmazonWebServices >> defaultProfile: aString [
	self client defaultProfile: aString
]

{ #category : #'as yet unclassified' }
GtAwsAmazonWebServices >> defaultRegion: aString [ 
	self client defaultRegion: aString
]

{ #category : #accessing }
GtAwsAmazonWebServices >> deleteAllInS3Url: s3Url [
	"Remove all the entries in the specified S3 bucket"

	self client
		run: (GtAwsCliArguments new
				endpointPrefix: 's3';
				operation: 'rm';
				add: (GtAwsCliFlag new name: 'recursive');
				add: (GtAwsCliArgument new
						key: 'exclude';
						value: ''))
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> ec2 [
	^ entityHolders at: 'EC2' ifAbsentPut: [ GtAwsEc2 new client: self ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> ec2Command: operation instanceId: instanceId notification: aString [
	"Perform the specified operation on the instanceId and notify the user.
	This requires a different AWS user profile than other operations.  Set up the profile prior to starting the machine, and then delete it after."
	"TODO: is this needed? and what for?"
	^ self primEc2Command: operation instanceId: instanceId
]

{ #category : #accessing }
GtAwsAmazonWebServices >> ec2GetInstance: anId [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'ec2';
					operation: 'describe-instances';
					add: (GtAwsCliArgument new
								key: 'instance-ids';
								value: anId)).

	^ GtAwsEc2Instance
		fromDictionary: (((STONJSON fromString: output) at: 'Reservations') first at: 'Instances') first
]

{ #category : #accessing }
GtAwsAmazonWebServices >> ec2InstanceTypes [
	"Answer a collection of the available instance types."

	| typesArray output instanceTypes |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'ec2';
					operation: 'describe-instance-types').

	typesArray := (STONJSON fromString: output trimBoth) at: #InstanceTypes.
	instanceTypes := Dictionary new.
	typesArray
		do: [ :each | 
			instanceTypes
				at: (each at: #InstanceType)
				put: (GtAwsInstanceType jsonObject: each) ].
	^ instanceTypes
]

{ #category : #accessing }
GtAwsAmazonWebServices >> ec2ListInstances [
	| output aCollection |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'ec2';
					operation: 'describe-instances').

	aCollection := (((STONJSON fromString: output) at: 'Reservations')
			flatCollect: [ :aReservation | aReservation at: 'Instances' ])
			collect: [ :aDict | (GtAwsEc2Instance fromDictionary: aDict) client: self ].

	^ GtAwsEc2InstanceGroup withAll: aCollection
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> efs [
	^ entityHolders at: 'EFS' ifAbsentPut: [ GtAwsEfs new client: self ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> efsListFileSystems [
	| output aCollection |
	output := self client run: (GtAwsCliArguments new
					endpointPrefix: 'efs';
					operation: 'describe-file-systems')..

	aCollection := ((STONJSON fromString: output) at: 'FileSystems')
			collect: [ :aDict | (GtAwsEfsFileSystem fromDictionary: aDict) client: self ].

	^ GtAwsEfsFileSystemGroup withAll: aCollection
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> eks [
	^ entityHolders at: 'EKS' ifAbsentPut: [ GtAwsEks new client: self ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> eksListClusters [
	| aCollection output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'eks';
					operation: 'list-clusters').

	aCollection := ((STONJSON fromString: output) at: 'clusters')
			collect: [ :aDict | (GtAwsEksCluster fromDictionary: aDict) client: self ].

	^ GtAwsEksClusterGroup withAll: aCollection
]

{ #category : #'as yet unclassified' }
GtAwsAmazonWebServices >> find: aResourceType orFind: anId InEndpoint: anEndpoint [
	entityHolders
		valuesDo: [ :anEntityHolder | 
			anEntityHolder entityId = aResourceType
				ifTrue: [ (anEntityHolder findEntityWithId: anId) ifNotNil: [ :anEntity | ^ anEntity ] ] ].

	^ self perform: anEndpoint withArguments: {anId}
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> gtNavigationFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Navigation';
		priority: 1;
		items: [ self gtNavigations associations ];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> gtNavigations [
	^ OrderedDictionary new
		at: 'CloudFormation' put: self cloudformation;
		at: 'Lambda' put: self lambda;
		at: 'RDS' put: self rds;
		at: 'S3' put: self s3;
		at: 'EC2' put: self ec2;
		at: 'EKS' put: self eks;
		at: 'EFS' put: self efs;
		yourself
]

{ #category : #accessing }
GtAwsAmazonWebServices >> initialize [

	super initialize.
	entityHolders := Dictionary new.
	client := GtAwsClient new
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> lambda [
	^ entityHolders at: 'Lambda' ifAbsentPut: [ GtAwsLambda new client: self ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> lambdaGetFunction: anId [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'lambda';
					operation: 'get-function';
					add: (GtAwsCliArgument new
								key: 'function-name';
								value: anId)).

	^ (GtAwsLambdaFunction fromDictionary: (STONJSON fromString: output))
		client: self
]

{ #category : #accessing }
GtAwsAmazonWebServices >> lambdaListFunctionTagsFor: anArn [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'lambda';
					operation: 'list-tags';
					add: (GtAwsCliArgument new
								key: 'resource';
								value: anArn)).

	^ (STONJSON fromString: output) at: 'Tags'
]

{ #category : #accessing }
GtAwsAmazonWebServices >> lambdaListFunctions [
	| output aCollection |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'lambda';
					operation: 'list-functions').

	aCollection := ((STONJSON fromString: output) at: 'Functions')
			collect: [ :aDict | (GtAwsLambdaFunction fromDictionary: aDict) client: self ].

	^ GtAwsLambdaFunctionGroup withAll: aCollection
]

{ #category : #accessing }
GtAwsAmazonWebServices >> primEc2Command: operation instanceId: aString [
	^ self client
		run: (GtAwsCliArguments new
				endpointPrefix: 'ec2';
				operation: operation;
				add: (GtAwsCliArgument new
							key: 'instance-ids';
							value: aString))
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> rds [
	^ entityHolders at: 'RDS' ifAbsentPut: [ GtAwsRds new client: self ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> rdsDescribeInstance: anId [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'rds';
					operation: 'describe-db-instances';
					add: (GtAwsCliArgument new
								key: 'db-instance-identifier';
								value: anId)).

	^ GtAwsRDSInstance new
		client: self;
		jsonObject: (STONJSON fromString: output)
]

{ #category : #accessing }
GtAwsAmazonWebServices >> rdsDescribeInstances [
	| aCollection output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'rds';
					operation: 'describe-db-instances').
								
	aCollection := ((STONJSON fromString: output) at: 'DBInstances')
			collect: [ :anInstance | (GtAwsRDSInstance fromDictionary: anInstance) client: self ].

	^ GtAwsRDSInstanceGroup withAll: aCollection
]

{ #category : #'gt - extensions' }
GtAwsAmazonWebServices >> s3 [
	^entityHolders at: 'S3' ifAbsentPut: [  GtAwsS3 new client: self]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3Cp: srcString to: dstString [
	"Copy srcString to dstString.
	One must be in the format of a s3 URL, i.e. s3://path/to/file.
	The other must be a local file."
	^ self client run: {
				's3'.
				'cp'.
				srcString.
				dstString.
				}.
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
GtAwsAmazonWebServices >> s3GetBucket: aBucketId [
	^ self s3Ls detect: [ :aBucket | aBucket name = aBucketId ]
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3ListTagsForBucket: aName [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 's3api';
					operation: 'get-bucket-tagging';
					add: (GtAwsCliArgument new
								key: 'bucket';
								value: aName)).

	^ (STONJSON fromString: output) at: 'TagSet'
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3Ls [
	| output |
	output := self client
			run: {'s3'.
					'ls'}.
	^ GtAwsS3BucketGroup
		withAll: (output lines
				collect: [ :aLine | 
					| words |
					words := Character space split: aLine.
					GtAwsS3Bucket new
						modifiedAt: (DateAndTime fromString: words first , ' ' , words second);
						name: words third;
						client: self ])
]

{ #category : #accessing }
GtAwsAmazonWebServices >> s3ls: aString [
	"Answer the contents of the supplied S3 bucket.
	aString must be in the format of a s3 URL, i.e. s3://path/to/dir.
	For now answer { file name string. file size string. file date string. }
	Directories have a trailing slash (/), 0 size and nil date."

	| output files fileRx directoryRx |
	output := self client
			run: {'s3'.
					'ls'.
					aString}.

	fileRx := '([0-9\-]+ [0-9:]+) +(\d+) +(.+)' asRegex.
	directoryRx := ' *PRE (.+)' asRegex.
	files := Array
			streamContents: [ :stream | 
				output
					linesDo: [ :each | 
						| search |
						search := fileRx search: each.
						search
							ifTrue: [ stream
									nextPut: (GtAwsS3FileReference new
											s3DirectoryUrl: aString;
											basename: (fileRx subexpressions: 4) first;
											size: (fileRx subexpressions: 3) first asNumber;
											modificationTime: (fileRx subexpressions: 2) first) ].
						search := directoryRx search: each.
						search
							ifTrue: [ stream
									nextPut: (GtAwsS3FileReference new
											s3DirectoryUrl: aString;
											basename: (directoryRx subexpressions: 2) first;
											size: 0) ] ] ].
	^ files
]

{ #category : #accessing }
GtAwsAmazonWebServices >> sqsGetQueueAttributes: aQueueId [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'sqs';
					operation: 'get-queue-attributes';
					add: (GtAwsCliArgument new
							key: 'queue-url';
							value: aQueueId);
					add: (GtAwsCliArgument new
							key: 'attribute-names';
							value: 'All')).

	^ GtAwsSQSQueue new
		client: self;
		url: aQueueId;
		attributes: ((STONJSON fromString: output) at: 'Attributes')
]

{ #category : #accessing }
GtAwsAmazonWebServices >> sqsListQueueTagsFor: aUrl [
	| output |
	output := self client
			run: (GtAwsCliArguments new
					endpointPrefix: 'sqs';
					operation: 'list-queue-tags';
					add: (GtAwsCliArgument new
							key: 'queue-url';
							value: aUrl)).

	^ output
		ifEmpty: [ Dictionary new ]
		ifNotEmpty: [ (STONJSON fromString: output) at: 'Tags' ]
]
