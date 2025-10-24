Class {
	#name : #GtAwsAsgActivity,
	#superclass : #GtAwsObject,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsAsgActivity >> activityId [

	^ jsonObject at: #ActivityId
]

{ #category : #accessing }
GtAwsAsgActivity >> autoScalingGroupArn [

	^ jsonObject at: #AutoScalingGroupARN
]

{ #category : #accessing }
GtAwsAsgActivity >> autoScalingGroupName [

	^ jsonObject at: #AutoScalingGroupName
]

{ #category : #accessing }
GtAwsAsgActivity >> cause [

	^ jsonObject at: #Cause
]

{ #category : #accessing }
GtAwsAsgActivity >> description [

	^ jsonObject at: #Description
]

{ #category : #accessing }
GtAwsAsgActivity >> details [

	^ jsonObject at: #Details
]

{ #category : #accessing }
GtAwsAsgActivity >> endTime [

	^ DateAndTime readFrom: (jsonObject at: #EndTime) readStream
]

{ #category : #accessing }
GtAwsAsgActivity >> progress [

	^ jsonObject at: #Progress
]

{ #category : #accessing }
GtAwsAsgActivity >> startTime [

	^ DateAndTime readFrom: (jsonObject at: #StartTime) readStream
]

{ #category : #accessing }
GtAwsAsgActivity >> statusCode [

	^ jsonObject at: #StatusCode
]
