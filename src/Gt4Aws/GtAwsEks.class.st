Class {
	#name : #GtAwsEks,
	#superclass : #GtAwsEntityHolder,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEks >> entityId [
	^ 'AWS::EKS::Cluster'
]

{ #category : #accessing }
GtAwsEks >> entityName [
	^ 'Clusters'
]

{ #category : #accessing }
GtAwsEks >> refreshEntities [
	^ self client eksListClusters
]

{ #category : #accessing }
GtAwsEks >> serviceName [
	^ 'AWS Elastic Kubernetes Service'
]

{ #category : #accessing }
GtAwsEks >> viewName [
	^ #gtLiveFor:
]
