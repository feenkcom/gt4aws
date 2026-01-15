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
	#classVars : [
		'DescriptionCaches',
		'DescriptionMutex'
	],
	#category : #'Gt4Aws-Management'
}

{ #category : #accessing }
GtAwsAutoScalingGroupManager class >> descriptionCacheForRegion: regionName group: groupName [

	^ self descriptionMutex critical: [ self descriptionCaches
		at: (self descriptionKeyForRegion: regionName group: groupName)
		ifAbsentPut: [ | cacheObject |
			cacheObject := GtUpdatingTimeCachedObject
				get: [ GtRrWorker isCommandLineWorker ifTrue: 
					[ cacheObject stop.
					Processor activeProcess terminate ].
					(GtAwsDescribeAutoscalingGroupsCommand new
						groupName: groupName;
						region: regionName;
						executeWithStonRetry) first ]
				timeout: 20 seconds
				active: 5 minutes ] ]
]

{ #category : #'private - accessing' }
GtAwsAutoScalingGroupManager class >> descriptionCaches [

	^ DescriptionCaches ifNil: [ DescriptionCaches := Dictionary new ]
]

{ #category : #'private - accessing' }
GtAwsAutoScalingGroupManager class >> descriptionKeyForRegion: regionName group: groupName [

	^ regionName -> groupName
]

{ #category : #'private - accessing' }
GtAwsAutoScalingGroupManager class >> descriptionMutex [

	^ DescriptionMutex ifNil: [ DescriptionMutex := Mutex new ]
]

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

	^ descriptionCache ifNil: [ descriptionCache := 
		self class descriptionCacheForRegion: regionName group: groupName ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> descriptionState [
	"Answer the time at which the description cache was retrieved"
	
	^ descriptionCache state
]

{ #category : #accessing }
GtAwsAutoScalingGroupManager >> descriptionWaitTime [
	"Answer the number of seconds to wait for the receiver's description to be retrieved"

	^ 20
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

	^ self descriptionCache waitForValue: self descriptionWaitTime.
]
