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
	self assert: (GtAwsAmazonWebServices default instanceTypes at: 'm6a.32xlarge') coreCount
		equals: 64.
]

{ #category : #examples }
GtAwsInstanceTypeExamples >> correctedCoreCount [
	"Confirm that the corrected core count for an instance type can be successfully retrieved."
	<gtExample>
	<noTest>

	self assert: (GtAwsAmazonWebServices default instanceTypes at: 'm6a.32xlarge') correctedCoreCount
		equals: 32.
]
