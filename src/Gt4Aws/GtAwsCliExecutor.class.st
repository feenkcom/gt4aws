Class {
	#name : #GtAwsCliExecutor,
	#superclass : #GtAwsOperationExecutor,
	#category : #'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsCliExecutor >> execute [
	^ GtAwsAmazonWebServices default
		runArguments: self prepareOperation toArguments
		returnBlock: #stdout
		retryCount: 3
]

{ #category : #accessing }
GtAwsCliExecutor >> operationToArguments [
	| mangledOperationName |
	mangledOperationName := '-'
			join: ((self operation name) splitCamelCase collect: #asLowercase).
	^ Array streamContents: [ :stream |
		stream
			nextPut: self service endpointPrefix;
			nextPut: mangledOperationName;
			nextPutAll: (argumentsArray ifNil: [ #() ]) ]
]
