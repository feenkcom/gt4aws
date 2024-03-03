Class {
	#name : #GtAwsInstanceType,
	#superclass : #GtAwsObject,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsInstanceType >> coreCount [

	^ (jsonObject at: #VCpuInfo) at: #DefaultCores
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
