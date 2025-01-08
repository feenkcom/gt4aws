Class {
	#name : #GtAwsDescribeAutoscalingGroupsCommand,
	#superclass : #GtAwsAutoscalingCommand,
	#category : #'Gt4Aws-Commands'
}

{ #category : #initialization }
GtAwsDescribeAutoscalingGroupsCommand >> initialize [

	super initialize.
	arguments operation: 'describe-auto-scaling-groups'.
]

{ #category : #'as yet unclassified' }
GtAwsDescribeAutoscalingGroupsCommand >> process: aString [
	| dict result |

	dict := STONJSON fromString: aString.
	^ (result := dict at: 'AutoScalingGroups')
		ifEmpty: [ KeyNotFound new
			key: key;
			signal ]
		ifNotEmpty: [ result collect: [ :each | GtAwsAutoScalingGroupDescription jsonObject: each ] ]
]
