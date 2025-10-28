Class {
	#name : #GtAwsCliExecutor,
	#superclass : #GtAwsOperationExecutor,
	#category : 'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsCliExecutor >> execute [
	^ GtAwsClient new
		runArguments: self prepareOperation toArguments
		returnBlock: #stdout
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
