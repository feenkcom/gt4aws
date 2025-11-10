Class {
	#name : #GtAwsDescribeAutoscalingGroupsCommand,
	#superclass : #GtAwsAutoscalingCommand,
	#category : #'Gt4Aws-Commands'
}

{ #category : #execution }
GtAwsDescribeAutoscalingGroupsCommand >> execute [
	"Retrieve the ASG description.
	The aws command occassionally returns a partial result, i.e. the JSON output terminates early.  In this case, retry a couple of times."

	^ [ super execute ]
		on: STONReaderError
		do: [ :ex |
			retryCount := retryCount - 1.
			retryCount > 0
				ifTrue: [ 1 second wait. self execute ]
				ifFalse: [ ex pass ] ].
]

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
			key: groupName;
			signal ]
		ifNotEmpty: [ result collect: [ :each | GtAwsAutoScalingGroupDescription jsonObject: each ] ]
]
