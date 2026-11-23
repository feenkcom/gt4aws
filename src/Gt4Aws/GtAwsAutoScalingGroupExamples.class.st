"
I show how Gt4Aws reads auto scaling groups, their instances and their scaling activities.
The AWS CLI answers JSON, read with STONJSON: the keys and the values, such as the lifecycle state of an instance, are Strings.
"
Class {
	#name : #GtAwsAutoScalingGroupExamples,
	#superclass : #Object,
	#category : #'Gt4Aws-Examples'
}

{ #category : #examples }
GtAwsAutoScalingGroupExamples >> autoScalingGroup [
	"An auto scaling group, read by the command that describes it"
	<gtExample>
	<return: #GtAwsAutoScalingGroupDescription>
	| groups group |
	groups := GtAwsDescribeAutoscalingGroupsCommand new process: self autoScalingGroupsJson.
	self assert: groups size equals: 1.
	group := groups first.
	self assert: group groupName equals: 'example-workers'.
	self assert: group regionName equals: 'eu-central-1'.
	self assert: (group arn endsWith: 'autoScalingGroupName/example-workers').
	self assert: group minCapacity equals: 0.
	self assert: group maxCapacity equals: 10.
	self assert: group desiredCapacity equals: 3.
	self assert: group instanceCount equals: 4.
	self assert: group preTerminatingCount equals: 3.
	self assert: group isIdle not.
	^ group
]

{ #category : #examples }
GtAwsAutoScalingGroupExamples >> autoScalingGroupInstances [
	"The instances of an auto scaling group, and the ones in service: their lifecycle state is a String"
	<gtExample>
	<return: #Array>
	| group instances first |
	group := self autoScalingGroup.
	instances := group instances asArray.
	self
		assert: (instances collect: [ :each | each instanceId ])
		equals: #('i-0000000000000001' 'i-0000000000000002' 'i-0000000000000003' 'i-0000000000000004').
	first := instances first.
	self assert: first instanceType equals: 'c5.xlarge'.
	self assert: first availabilityZone equals: 'eu-central-1a'.
	self assert: first lifecycleState equals: 'InService'.
	self assert: first healthStatus equals: 'Healthy'.
	self assert: first weightedCapacity equals: 2.
	self assert: first protectedFromScaleIn not.
	self assert: first printString equals: 'i-0000000000000001'.
	self assert: first isInService.
	self assert: first isTerminating not.
	self
		assert: (group instancesInService collect: [ :each | each instanceId ]) asArray
		equals: #('i-0000000000000001' 'i-0000000000000003').
	self assert: group capacityInService equals: 3.
	self assert: group weightInService equals: 3.
	self
		assert: (group preTerminatingInstances collect: [ :each | each instanceId ]) asArray
		equals: #('i-0000000000000001' 'i-0000000000000002' 'i-0000000000000003').
	self
		assert: (group instancesTerminating collect: [ :each | each instanceId ]) asArray
		equals: #('i-0000000000000004').
	^ instances
]

{ #category : #'examples - data' }
GtAwsAutoScalingGroupExamples >> autoScalingGroupsJson [
	"The output of aws autoscaling describe-auto-scaling-groups for a group with four instances:
	two in service, one pending and one terminating"

	^ '{"AutoScalingGroups":[{
	"AutoScalingGroupName":"example-workers",
	"AutoScalingGroupARN":"arn:aws:autoscaling:eu-central-1:123456789012:autoScalingGroup:0123abcd-0000-4000-8000-000000000000:autoScalingGroupName/example-workers",
	"MinSize":0,
	"MaxSize":10,
	"DesiredCapacity":3,
	"Instances":[
		{"InstanceId":"i-0000000000000001","InstanceType":"c5.xlarge","AvailabilityZone":"eu-central-1a","LifecycleState":"InService","HealthStatus":"Healthy","WeightedCapacity":"2","ProtectedFromScaleIn":false},
		{"InstanceId":"i-0000000000000002","InstanceType":"c5.xlarge","AvailabilityZone":"eu-central-1b","LifecycleState":"Pending","HealthStatus":"Healthy","WeightedCapacity":"2","ProtectedFromScaleIn":false},
		{"InstanceId":"i-0000000000000003","InstanceType":"m5.large","AvailabilityZone":"eu-central-1a","LifecycleState":"InService","HealthStatus":"Healthy","WeightedCapacity":"1","ProtectedFromScaleIn":true},
		{"InstanceId":"i-0000000000000004","InstanceType":"c5.xlarge","AvailabilityZone":"eu-central-1c","LifecycleState":"Terminating:Wait","HealthStatus":"Unhealthy","WeightedCapacity":"2","ProtectedFromScaleIn":false}]}]}'
]

{ #category : #examples }
GtAwsAutoScalingGroupExamples >> idleAutoScalingGroup [
	"A group scaled down to 0 whose instances are all terminating is idle"
	<gtExample>
	<return: #GtAwsAutoScalingGroupDescription>
	| group |
	group := (GtAwsDescribeAutoscalingGroupsCommand new process: self idleAutoScalingGroupsJson) first.
	self assert: group desiredCapacity equals: 0.
	self assert: group instanceCount equals: 1.
	self assert: group preTerminatingCount equals: 0.
	self assert: group instancesInService isEmpty.
	self assert: group capacityInService equals: 0.
	self assert: group isIdle.
	^ group
]

{ #category : #'examples - data' }
GtAwsAutoScalingGroupExamples >> idleAutoScalingGroupsJson [
	"The output of aws autoscaling describe-auto-scaling-groups for a group scaled down to 0, its last instance terminating"

	^ '{"AutoScalingGroups":[{
	"AutoScalingGroupName":"example-workers",
	"AutoScalingGroupARN":"arn:aws:autoscaling:eu-central-1:123456789012:autoScalingGroup:0123abcd-0000-4000-8000-000000000000:autoScalingGroupName/example-workers",
	"MinSize":0,
	"MaxSize":10,
	"DesiredCapacity":0,
	"Instances":[
		{"InstanceId":"i-0000000000000004","InstanceType":"c5.xlarge","AvailabilityZone":"eu-central-1c","LifecycleState":"Terminating:Proceed","HealthStatus":"Healthy","WeightedCapacity":"2","ProtectedFromScaleIn":false}]}]}'
]

{ #category : #examples }
GtAwsAutoScalingGroupExamples >> instanceDescription [
	"The description of an instance, read as GtAwsInstance>>#description reads the output of aws ec2 describe-instances"
	<gtExample>
	<return: #GtAwsInstanceDescription>
	| description |
	description := GtAwsInstanceDescription jsonObject:
		((STONJSON fromString: self instanceDescriptionJson) at: 'Reservations') first.
	self assert: description instanceId equals: 'i-0000000000000001'.
	self assert: description privateIpAddress equals: '10.0.1.23'.
	self assert: description coreCount equals: 2.
	self assert: (description cpuOptions at: 'ThreadsPerCore') equals: 2.
	^ description
]

{ #category : #'examples - data' }
GtAwsAutoScalingGroupExamples >> instanceDescriptionJson [
	"The output of aws ec2 describe-instances for one instance"

	^ '{"Reservations":[{
	"ReservationId":"r-0000000000000001",
	"Instances":[{"InstanceId":"i-0000000000000001","InstanceType":"c5.xlarge","PrivateIpAddress":"10.0.1.23","CpuOptions":{"CoreCount":2,"ThreadsPerCore":2}}]}]}'
]

{ #category : #examples }
GtAwsAutoScalingGroupExamples >> scalingActivities [
	"The scaling activities of a group, read by the command that describes them"
	<gtExample>
	<return: #GtAwsAsgActivityGroup>
	| activities activity |
	activities := GtAwsDescribeAutoscalingGroupActivityCommand new process: self scalingActivitiesJson.
	self assert: activities size equals: 1.
	activity := activities first.
	self assert: activity activityId equals: '0123abcd-1111-4000-8000-000000000000'.
	self assert: activity autoScalingGroupName equals: 'example-workers'.
	self assert: (activity autoScalingGroupArn endsWith: 'autoScalingGroupName/example-workers').
	self assert: activity description equals: 'Launching a new EC2 instance: i-0000000000000002'.
	self assert: (activity cause includesSubstring: 'from 2 to 3').
	self assert: activity statusCode equals: 'Successful'.
	self assert: activity progress equals: 100.
	self assert: (activity details includesSubstring: 'subnet-0123').
	self assert: activity startTime equals: (DateAndTime fromString: '2026-11-20T10:15:30.123Z').
	self assert: activity endTime equals: (DateAndTime fromString: '2026-11-20T10:16:02.456Z').
	^ activities
]

{ #category : #'examples - data' }
GtAwsAutoScalingGroupExamples >> scalingActivitiesJson [
	"The output of aws autoscaling describe-scaling-activities with one activity"

	^ '{"Activities":[{
	"ActivityId":"0123abcd-1111-4000-8000-000000000000",
	"AutoScalingGroupName":"example-workers",
	"AutoScalingGroupARN":"arn:aws:autoscaling:eu-central-1:123456789012:autoScalingGroup:0123abcd-0000-4000-8000-000000000000:autoScalingGroupName/example-workers",
	"Description":"Launching a new EC2 instance: i-0000000000000002",
	"Cause":"At 2026-11-20T10:15:00Z a user request update of AutoScalingGroup constraints changed the desired capacity from 2 to 3.",
	"StartTime":"2026-11-20T10:15:30.123Z",
	"EndTime":"2026-11-20T10:16:02.456Z",
	"StatusCode":"Successful",
	"Progress":100,
	"Details":"{\"Subnet ID\":\"subnet-0123\",\"Availability Zone\":\"eu-central-1b\"}"}]}'
]
