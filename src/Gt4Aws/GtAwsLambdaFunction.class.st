Class {
	#name : #GtAwsLambdaFunction,
	#superclass : #GtAwsObject,
	#instVars : [
		'description',
		'arn',
		'name',
		'version',
		'runtime'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsLambdaFunction class >> fromDictionary: aDict [
	^ self new
		jsonObject: aDict;
		description: (aDict at: 'Description');
		arn: (aDict at: 'FunctionArn');
		name: (aDict at: 'FunctionName');
		version: (aDict at: 'Version');
		runtime: (aDict at: 'Runtime')
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
GtAwsLambdaFunction >> name [
	^ name
]

{ #category : #accessing }
GtAwsLambdaFunction >> name: anObject [
	name := anObject
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
GtAwsLambdaFunction >> version [
	^ version
]

{ #category : #accessing }
GtAwsLambdaFunction >> version: anObject [
	version := anObject
]
