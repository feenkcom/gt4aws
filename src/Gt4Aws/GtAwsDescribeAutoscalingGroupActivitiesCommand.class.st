Class {
	#name : #GtAwsDescribeAutoscalingGroupActivitiesCommand,
	#superclass : #GtAwsAutoscalingCommand,
	#category : #'Gt4Aws-Commands'
}

{ #category : #initialization }
GtAwsDescribeAutoscalingGroupActivitiesCommand >> initialize [

	super initialize.
	arguments operation: 'describe-scaling-activities'.
]

{ #category : #accessing }
GtAwsDescribeAutoscalingGroupActivitiesCommand >> maxItems: aNumber [

	arguments add: (GtAwsCliArgument new
		key: 'max-items';
		value: aNumber asString)
]

{ #category : #private }
GtAwsDescribeAutoscalingGroupActivitiesCommand >> process: aString [
	| dict result |

	dict := STONJSON fromString: aString.
	result := (dict at: 'Activities')
		ifEmpty: [ KeyNotFound new
			key: groupName;
			signal ]
		ifNotEmpty: [ :anArray | anArray collect: [ :each | GtAwsAsgActivity jsonObject: each ] ].
	^ GtAwsAsgActivityGroup withAll: result.
]
