Class {
	#name : #GtAwsInstanceType,
	#superclass : #GtAwsObject,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsInstanceType class >> coreCountCorrections [
	"Answer a dictionary of
		instanceType -> coreCount
	for known errors in the AWS values"

	^ CoreCountCorrections ifNil: [ CoreCountCorrections :=
		{ 'm6a.32xlarge' -> 32.
		'm6id.24xlarge' -> 24.
		'm6i.24xlarge' -> 24.
		'm6i.32xlarge' -> 32.
		'r7a.32xlarge' -> 64.
		} asDictionary ]
]

{ #category : #accessing }
GtAwsInstanceType >> coreCount [

	^ (jsonObject at: #VCpuInfo) at: #DefaultCores
]

{ #category : #accessing }
GtAwsInstanceType >> correctedCoreCount [
	"Answer the receiver's number of cores, corrected where known"

	^ self class coreCountCorrections
		at: self instanceType
		ifAbsent: [ self coreCount ]
]

{ #category : #accessing }
GtAwsInstanceType >> instanceType [

	^ jsonObject at: #InstanceType
]

{ #category : #accessing }
GtAwsInstanceType >> printOn: aStream [

	jsonObject ifNil: [ ^ super printOn: aStream ].
	aStream << self instanceType
]
