Class {
	#name : #GtAwsInstance,
	#superclass : #GtAwsObject,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsInstance >> availabilityZone [

	^ jsonObject at: #AvailabilityZone
]

{ #category : #accessing }
GtAwsInstance >> coreCount [
	"Answer the number of cores in the instance."

	^ (GtAwsAmazonWebServices default ec2 instanceTypes at: self instanceType) coreCount
]

{ #category : #accessing }
GtAwsInstance >> description [
	| wrapper |

	wrapper := STONJSON fromString: (GtAwsAmazonWebServices default
		ec2Command: 'describe-instances' 
		instanceId: self instanceId 
		notification: nil).
	wrapper := wrapper at: #Reservations.
	self assert: wrapper size equals: 1.
	^ GtAwsInstanceDescription jsonObject: wrapper first.
]

{ #category : #accessing }
GtAwsInstance >> healthStatus [

	^ jsonObject at: #HealthStatus
]

{ #category : #accessing }
GtAwsInstance >> instanceId [

	^ jsonObject at: #InstanceId
]

{ #category : #accessing }
GtAwsInstance >> instanceType [

	^ jsonObject at: #InstanceType
]

{ #category : #testing }
GtAwsInstance >> isInService [

	^ self lifecycleState = #InService
]

{ #category : #testing }
GtAwsInstance >> isTerminating [

	^ self lifecycleState beginsWith: 'Terminating'
]

{ #category : #accessing }
GtAwsInstance >> lifecycleState [

	^ jsonObject at: #LifecycleState
]

{ #category : #printing }
GtAwsInstance >> printOn: aStream [

	jsonObject ifNil: [ ^ super printOn: aStream ].
	aStream << self instanceId.
]

{ #category : #accessing }
GtAwsInstance >> protectedFromScaleIn [

	^ jsonObject at: #ProtectedFromScaleIn
]

{ #category : #accessing }
GtAwsInstance >> weightedCapacity [

	^ (jsonObject at: #WeightedCapacity) asNumber
]
