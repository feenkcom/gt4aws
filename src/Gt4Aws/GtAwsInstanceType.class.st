Class {
	#name : #GtAwsInstanceType,
	#superclass : #GtAwsObject,
	#classVars : [
		'CoreCountCorrections'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsInstanceType >> coreCount [

	^ (jsonObject at: 'VCpuInfo') at: 'DefaultCores'
]

{ #category : #accessing }
GtAwsInstanceType >> instanceType [

	^ jsonObject at: 'InstanceType'
]

{ #category : #accessing }
GtAwsInstanceType >> printOn: aStream [

	jsonObject ifNil: [ ^ super printOn: aStream ].
	aStream << self instanceType
]

{ #category : #accessing }
GtAwsInstanceType >> totalMemory [
	^ ((jsonObject at: 'MemoryInfo') at: 'SizeInMiB') * 1024 * 1024
]

{ #category : #'as yet unclassified' }
GtAwsInstanceType >> vCpuCount [

	^ (jsonObject at: #VCpuInfo) at: #DefaultVCpus
]
