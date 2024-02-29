Class {
	#name : #GtAwsLambdaFunction,
	#superclass : #GtAwsObject,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsLambdaFunction class >> lookupEndpoint [
	^ #lambdaGetFunction:
]

{ #category : #accessing }
GtAwsLambdaFunction class >> resourceType [
	^ 'AWS::Lambda::Function'
]
