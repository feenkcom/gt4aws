Class {
	#name : #GtAwsIAM,
	#superclass : #GtAwsEntityHolder,
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsIAM >> entityId [
	^ 'AWS::IAM::Role'
]

{ #category : #'as yet unclassified' }
GtAwsIAM >> entityName [
	^ 'Roles'
]

{ #category : #'as yet unclassified' }
GtAwsIAM >> refreshEntities [
	^ self client iamListRoles
]

{ #category : #'as yet unclassified' }
GtAwsIAM >> serviceName [
	^ 'AWS Identity and Access Management'
]

{ #category : #'as yet unclassified' }
GtAwsIAM >> viewName [
	^ #gtRolesFor:
]
