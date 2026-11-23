Class {
	#name : #GtAwsInstanceTypeExamples,
	#superclass : #Object,
	#category : #'Gt4Aws-Examples'
}

{ #category : #examples }
GtAwsInstanceTypeExamples >> instanceTypes [
	"The instance types by name, read by the command that describes them"
	<gtExample>
	<return: #Dictionary>
	| types type |
	types := GtAwsEc2InstanceTypesCommand new process: self instanceTypesJson.
	self assert: types keys asSet equals: #('c5.xlarge' 'm5.large') asSet.
	type := types at: 'c5.xlarge'.
	self assert: type instanceType equals: 'c5.xlarge'.
	self assert: type vCpuCount equals: 4.
	self assert: type coreCount equals: 2.
	self assert: type totalMemory equals: 8192 * 1024 * 1024.
	self assert: type printString equals: 'c5.xlarge'.
	self assert: (types at: 'm5.large') vCpuCount equals: 2.
	^ types
]

{ #category : #'examples - data' }
GtAwsInstanceTypeExamples >> instanceTypesJson [
	"The output of aws ec2 describe-instance-types for two instance types"

	^ '{"InstanceTypes":[
	{"InstanceType":"c5.xlarge","VCpuInfo":{"DefaultVCpus":4,"DefaultCores":2,"DefaultThreadsPerCore":2},"MemoryInfo":{"SizeInMiB":8192}},
	{"InstanceType":"m5.large","VCpuInfo":{"DefaultVCpus":2,"DefaultCores":1,"DefaultThreadsPerCore":2},"MemoryInfo":{"SizeInMiB":8192}}]}'
]
