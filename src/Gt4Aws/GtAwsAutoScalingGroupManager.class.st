"
The intention is that GtAwsAutoScalingGroupManager eventually provides the ability to control the state of AWS ASGs.  For now, it simply retrieves the description.
"
Class {
	#name : #GtAwsAutoScalingGroupManager,
	#superclass : #Object,
	#instVars : [
		'descriptionCache',
		'regionName',
		'groupName'
	],
	#category : #'Gt4Aws-Management'
}

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> description [
	"Answer a description of the cluster.  
	This is an expensive operation and changes relatively rarely, so is cached."

	^ self descriptionCache value.
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> descriptionCache [
	"Answer a description of the cluster.  
	This is an expensive operation and changes relatively rarely, so is cached for the time specified below."

	^ descriptionCache ifNil: [ descriptionCache := GtUpdatingTimeCachedObject 
		get: [ [ (GtAwsDescribeAutoscalingGroupsCommand new 
				groupName: groupName;
				region: regionName;
				executeWithStonRetry) first ]
					on: Error
					do: [ :ex | GtRrWorker isCommandLineWorker
						ifFalse: [ ex pass ] ] ]
		timeout: 20 seconds
		active: 5 minutes ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> descriptionState [
	"Answer the time at which the description cache was retrieved"
	
	^ descriptionCache state
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> groupName [
	^groupName
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> groupName: anObject [
	groupName := anObject
]

{ #category : #ui }
GtAwsAutoScalingGroupManager >> gtSummaryFor: aView [
	<gtView>

	descriptionCache ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Summary';
		priority: 10;
		object: [ descriptionCache ];
		view: #gtSummaryFor:
]

{ #category : #testing }
GtAwsAutoScalingGroupManager >> isIdle [
	"Answer a boolean indicating if the receiver is idle.
	Since this is used for ASG control, wait for the description to appear."

	^ self waitForDescription isIdle
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> lastRetrievedTime [
	"Answer the time at which the description cache was retrieved"
	
	^ descriptionCache lastRetrievedTime
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> regionName [
	^regionName
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> regionName: anObject [
	regionName := anObject
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> waitForDescription [
	"Answer the receiver's description, waiting if it isn't yet available."
	| maxRetries retryCount delay description |

	maxRetries := 9.
	delay := 1 second.
	retryCount := 0.
	[ description := self description.
	description isNil and: [ retryCount <= maxRetries ]. ] whileTrue:
		[ retryCount := retryCount + 1.
		delay wait. ].
	description ifNil:
		[ self error: 'Unable to retrieve description' ].
	^ description
]
