Class {
	#name : #GtAwsDescribeAutoscalingGroupActivityCommand,
	#superclass : #GtAwsAutoscalingCommand,
	#category : #'Gt4Aws-Commands'
}

{ #category : #initialization }
GtAwsDescribeAutoscalingGroupActivityCommand >> initialize [

	super initialize.
	arguments operation: 'describe-scaling-activities'.
]

{ #category : #accessing }
GtAwsDescribeAutoscalingGroupActivityCommand >> maxItems: aNumber [

	arguments add: (GtAwsCliArgument new
		key: 'max-items';
		value: aNumber asString)
]

{ #category : #private }
GtAwsDescribeAutoscalingGroupActivityCommand >> process: aString [
	| dict result |

	dict := STONJSON fromString: aString.
	result := (dict at: 'Activities')
		ifEmpty: [ KeyNotFound new
			key: groupName;
			signal ]
		ifNotEmpty: [ :anArray | anArray collect: [ :each | GtAwsAsgActivity jsonObject: each ] ].
	^ GtAwsAsgActivityGroup withAll: result.
]
