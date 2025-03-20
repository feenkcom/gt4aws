Class {
	#name : #GtAwsInstanceTypeExamples,
	#superclass : #Object,
	#category : #'Gt4Aws-Examples'
}

{ #category : #examples }
GtAwsInstanceTypeExamples >> coreCount [
	"Confirm that the core count for an instance type can be successfully retrieved."
	<gtExample>
	<noTest>

	"This confirms that the data is being accessed correctly.
	AWS is reporting the wrong value, see #correctedCoreCount"
	self assert: (GtAwsAmazonWebServices default ec2 instanceTypes at: 'm6a.32xlarge') coreCount
		equals: 64.
]
