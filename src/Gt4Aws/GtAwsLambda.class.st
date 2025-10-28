Class {
	#name : #GtAwsLambda,
	#superclass : #GtAwsEntityHolder,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsLambda >> entityId [
	^ 'AWS::Lambda::Function'
]

{ #category : #accessing }
GtAwsLambda >> entityName [
	^ 'Functions'
]

{ #category : #accessing }
GtAwsLambda >> refreshEntities [
	^ self client lambdaListFunctions
]

{ #category : #accessing }
GtAwsLambda >> serviceName [
	^ 'AWS Lambda'
]

{ #category : #accessing }
GtAwsLambda >> viewName [
	^ #gtFunctionsFor:
]
