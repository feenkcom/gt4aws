Class {
	#name : #GtAwsRDSInstance,
	#superclass : #GtAwsObject,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsRDSInstance class >> lookupEndpoint [
	^ #rdsDescribeInstance:
]

{ #category : #accessing }
GtAwsRDSInstance class >> resourceType [
	^ 'AWS::RDS::DBInstance'
]
