Class {
	#name : #GtAwsInstanceDescription,
	#superclass : #GtAwsObject,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsInstanceDescription >> coreCount [

	^ self cpuOptions at: #CoreCount
]

{ #category : #private }
GtAwsInstanceDescription >> coreDictionary [

	^ (jsonObject at: #Instances) first
]

{ #category : #accessing }
GtAwsInstanceDescription >> cpuOptions [

	^ self coreDictionary at: #CpuOptions
]

{ #category : #accessing }
GtAwsInstanceDescription >> instanceId [

	^ self coreDictionary at: #InstanceId
]

{ #category : #accessing }
GtAwsInstanceDescription >> privateIpAddress [

	^ self coreDictionary at: #PrivateIpAddress.
]
