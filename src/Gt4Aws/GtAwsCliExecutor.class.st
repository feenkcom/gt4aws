Class {
	#name : #GtAwsCliExecutor,
	#superclass : #GtAwsOperationExecutor,
	#category : #'Gt4Aws-Executor'
}

{ #category : #accessing }
GtAwsCliExecutor >> execute [
	^ (GtAwsAmazonWebServices default
		awsRegion: self zone;
		setRegion: self zone)
		runArguments: self operationToArguments
		returnBlock: #stdout
		retryCount: 3
]

{ #category : #accessing }
GtAwsCliExecutor >> operationToArguments [
	| mangledOperationName |
	mangledOperationName := '-'
			join: ((self operation at: 'name') splitCamelCase collect: #asLowercase).
	^ {self service endpointPrefix.
		mangledOperationName}
]
