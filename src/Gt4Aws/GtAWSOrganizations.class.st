Class {
	#name : #GtAWSOrganizations,
	#superclass : #GtAwsEntityHolder,
	#category : 'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAWSOrganizations >> entityId [
	^ 'AWS::IAM::Organization'
]

{ #category : #'as yet unclassified' }
GtAWSOrganizations >> entityName [
	^ 'Organizations'
]

{ #category : #'as yet unclassified' }
GtAWSOrganizations >> lookupAccount: anId [
	^ self entities detect: [ :anAccount | anAccount id = anId ]
]

{ #category : #'as yet unclassified' }
GtAWSOrganizations >> refreshEntities [
	^ self client organizationsListAccounts
]

{ #category : #'as yet unclassified' }
GtAWSOrganizations >> serviceName [
	^ 'AWS Organizations'
]

{ #category : #'as yet unclassified' }
GtAWSOrganizations >> viewName [
	^ #gtAccountsFor:
]
