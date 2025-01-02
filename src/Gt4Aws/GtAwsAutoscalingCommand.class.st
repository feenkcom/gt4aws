Class {
	#name : #GtAwsAutoscalingCommand,
	#superclass : #GtAwsCommand,
	#instVars : [
		'key'
	],
	#category : #'Gt4Aws-Commands'
}

{ #category : #'as yet unclassified' }
GtAwsAutoscalingCommand >> groupName: aString [

	key := aString.
	arguments add: (GtAwsCliArgument new
		key: 'auto-scaling-group-name';
		value: aString)
]

{ #category : #'as yet unclassified' }
GtAwsAutoscalingCommand >> initialize [

	super initialize.
	arguments endpointPrefix: 'autoscaling'.
]
