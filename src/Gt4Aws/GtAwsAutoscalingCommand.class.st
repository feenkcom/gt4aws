Class {
	#name : #GtAwsAutoscalingCommand,
	#superclass : #GtAwsCommand,
	#instVars : [
		'groupName'
	],
	#category : #'Gt4Aws-Commands'
}

{ #category : #accessing }
GtAwsAutoscalingCommand >> groupName: aString [

	groupName := aString.
	arguments add: (GtAwsCliArgument
		key: 'auto-scaling-group-name'
		value: aString).
]

{ #category : #initialization }
GtAwsAutoscalingCommand >> initialize [

	super initialize.
	arguments endpointPrefix: 'autoscaling'.
]
