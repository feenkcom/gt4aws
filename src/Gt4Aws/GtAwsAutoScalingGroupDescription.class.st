Class {
	#name : #GtAwsAutoScalingGroupDescription,
	#superclass : #GtAwsObject,
	#instVars : [
		'groupName'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #lejsonv4 }
GtAwsAutoScalingGroupDescription class >> leJsonV4Name [

	^ #GtAwsAutoScalingGroupDescription
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> activeCoreCount [
	"Answer the number of active cores in the receiver.
	In this context pending cores are considered active since the machine has been allocated and is in the process of starting up."

	^ self preTerminatingInstances 
		inject: 0
		into: [ :s :v | s + v coreCount ]
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

{ #category : #'as yet unclassified' }
GtAwsAutoScalingGroupDescription >> groupName [

	^ groupName ifNil: [ jsonObject at: 'AutoScalingGroupName' ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> groupName: anObject [
	groupName := anObject
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

{ #category : #testing }
GtAwsAutoScalingGroupDescription >> isIdle [
	"Answer a boolean indicating whether the receiver's ASG is idle.
	It isn't idle until the desired capacity is 0 and all the instances are terminating (or gone)"

	^ self desiredCapacity = 0 and: [ self preTerminatingCount = 0 ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> launchTemplateOverrides [

	^ ((jsonObject at: 'MixedInstancesPolicy') 
		at: 'LaunchTemplate')
			at: 'Overrides'
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> preTerminatingCount [
	"Answer the number of instances that are either starting or running."

	^ ((jsonObject at: #Instances) reject: [ :each | 
		(each at: #LifecycleState) beginsWith: 'Terminat' ]) size.
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> preTerminatingInstances [
	"Answer the instances currently running in the ASG."

	^ (jsonObject at: #Instances) 
		reject: [ :each | 
			"Terminating lifecycle states: 
				Terminating:Wait
				Terminating:Proceed
				Terminated?"
			(each at: #LifecycleState) beginsWith: 'Terminat' ]
		thenCollect: [ :each |
			LwGtAwsAsgInstance jsonObject: each ].
]

{ #category : #printing }
GtAwsAutoScalingGroupDescription >> printOn: aStream [
	super printOn: aStream.
	aStream space.
	aStream parenthesize: 
			[aStream
				nextPutAll: self groupName displayString;
				space ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> weightForInstanceType: anInstanceType [
	"Answer the weight assigned to the given instance type for this ASG.
	Answer nil if the instance type isn't defined in the cluster."

	^ self launchTemplateOverrides
		detect: [ :each | (each at: 'InstanceType') = anInstanceType ]
		ifFound: [ :each | (each at: 'WeightedCapacity') asNumber ]
		ifNone: [ nil ]
]

{ #category : #accessing }
GtAwsAutoScalingGroupDescription >> weightInService [
	"Answer the number of cores currently available."

	^ self instancesInService
		inject: 0
		into: [ :s :v | s + v weightedCapacity ].
]
