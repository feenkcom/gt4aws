Class {
	#name : #GtAwsLambdaFunction,
	#superclass : #GtAwsObject,
	#instVars : [
		'description',
		'arn',
		'name',
		'version',
		'runtime',
		'tags'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsLambdaFunction class >> fromDictionary: aDict [
	| anInstance configDict |
	anInstance := self new jsonObject: aDict.

	configDict := (aDict includesKey: 'Configuration')
			ifTrue: [ aDict at: 'Configuration' ]
			ifFalse: [ aDict ].

	anInstance
		description: (configDict at: 'Description');
		arn: (configDict at: 'FunctionArn');
		name: (configDict at: 'FunctionName');
		version: (configDict at: 'Version');
		runtime: (configDict at: 'Runtime').

	^ anInstance
]

{ #category : #accessing }
GtAwsLambdaFunction class >> lookupEndpoint [
	^ #lambdaGetFunction:
]

{ #category : #accessing }
GtAwsLambdaFunction class >> resourceType [
	^ 'AWS::Lambda::Function'
]

{ #category : #accessing }
GtAwsLambdaFunction >> arn [
	^ arn
]

{ #category : #accessing }
GtAwsLambdaFunction >> arn: anObject [
	arn := anObject
]

{ #category : #accessing }
GtAwsLambdaFunction >> description [
	^ description
]

{ #category : #accessing }
GtAwsLambdaFunction >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtAwsLambdaFunction >> lookupInCloudFormation [
	^ self client cloudformation lookupObject: self name
]

{ #category : #accessing }
GtAwsLambdaFunction >> managementConsoleProperties [
	^ '/functions/', self name
]

{ #category : #accessing }
GtAwsLambdaFunction >> name [
	^ name
]

{ #category : #accessing }
GtAwsLambdaFunction >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAwsLambdaFunction >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
GtAwsLambdaFunction >> refreshTags [
	^ tags := self client lambdaListFunctionTagsFor: self arn
]

{ #category : #accessing }
GtAwsLambdaFunction >> runtime [
	^ runtime
]

{ #category : #accessing }
GtAwsLambdaFunction >> runtime: anObject [
	runtime := anObject
]

{ #category : #accessing }
GtAwsLambdaFunction >> tagAt: aName [
	^ self tags at: aName
]

{ #category : #accessing }
GtAwsLambdaFunction >> tags [
	^ tags ifNil: [ self refreshTags ]
]

{ #category : #accessing }
GtAwsLambdaFunction >> urlBaseName [
	^ 'lambda'
]

{ #category : #accessing }
GtAwsLambdaFunction >> version [
	^ version
]

{ #category : #accessing }
GtAwsLambdaFunction >> version: anObject [
	version := anObject
]
