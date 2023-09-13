Class {
	#name : #GtAwsAutoScalingGroupDescription,
	#superclass : #GtAwsObject,
	#instVars : [
		'groupName'
	],
	#category : #Gt4Aws
}

{ #category : #'instance  creation' }
GtAwsAutoScalingGroupDescription class >> forGroupName: aString [

	^ self new initializeGroupName: aString jsonObject: 
		(GtAwsAmazonWebServices uniqueInstance
			autoScalingGroupDescriptionFor: aString).
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> coreCount [
	"Answer the number of cores currently available."

	^ self instances
		inject: 0
		into: [ :s :v | s + v coreCount ].
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> coreCountInService [
	"Answer the number of cores currently available."

	^ self instancesInService
		inject: 0
		into: [ :s :v | s + v coreCount ].
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> coreCountTerminating [
	"Answer the number of cores currently available."

	^ self instancesTerminating
		inject: 0
		into: [ :s :v | s + v coreCount ].
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> desiredCapacity [

	^ jsonObject at: #DesiredCapacity.
]

{ #category : #initiailize }
GtAwsAutoScalingGroupDescription >> initializeGroupName: aString jsonObject: aJsonObject [

	jsonObject := aJsonObject at: #AutoScalingGroups.
	self assert: jsonObject size equals: 1.
	jsonObject := jsonObject first.
	self assert: (jsonObject at: #AutoScalingGroupName) equals: aString.
	groupName := aString.
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> instanceCount [
	"Answer the number of instances returned in the description."
	
	^ (jsonObject at: #Instances) size
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> instances [
	"Answer the instances currently running in the ASG."

	^ (jsonObject at: #Instances) collect: [ :each |
		GtAwsInstance jsonObject: each ].
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> instancesInService [
	^ self instances select: [ :anInstance |
		anInstance isInService ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> instancesTerminating [
	^ self instances select: [ :anInstance |
		anInstance isTerminating ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> preTerminatingCount [
	"Answer the number of instances that are either starting or running."

	^ ((jsonObject at: #Instances) reject: [ :each | 
		#(#Terminating #Terminated) includes: (each at: #LifecycleState) ]) size.
]
