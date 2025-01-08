Class {
	#name : #GtAwsCredentials,
	#superclass : #Object,
	#instVars : [
		'credentialFile',
		'accessKeyId',
		'secretAccessKey'
	],
	#category : #'Gt4Aws-Credentials'
}

{ #category : #accessing }
GtAwsCredentials >> accessKeyId [
	^ accessKeyId
]

{ #category : #accessing }
GtAwsCredentials >> accessKeyId: anObject [
	accessKeyId := anObject
]

{ #category : #accessing }
GtAwsCredentials >> credentialFile [
	^ credentialFile
]

{ #category : #accessing }
GtAwsCredentials >> credentialFile: anObject [
	credentialFile := anObject
]

{ #category : #defaults }
GtAwsCredentials >> defaultCredentialFile [
	^ FileLocator home / '.aws' / 'credentials'
]

{ #category : #checking }
GtAwsCredentials >> gtFileFor: aView [
	<gtView>
	self hasCredentialFile ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Credentials file';
		priority: 2;
		object: [ self credentialFile ];
		view: #gtContentsFor:
]

{ #category : #checking }
GtAwsCredentials >> gtSummary [
	^ {'Credentials file' -> self credentialFile.
		'Access Key ID' -> self accessKeyId.
		'Secret Access Key' -> self secretAccessKey}
]

{ #category : #checking }
GtAwsCredentials >> gtSummaryFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Summary';
		priority: 1;
		items: [ self gtSummary ];
		column: 'Property' text: #key width: 120;
		column: 'Value' text: #value;
		send: #value;
		actionUpdateButton
]

{ #category : #checking }
GtAwsCredentials >> hasCredentialFile [
	^ self credentialFile isNotNil and: [ self credentialFile exists ]
]

{ #category : #initialization }
GtAwsCredentials >> initialize [
	credentialFile := self defaultCredentialFile
]

{ #category : #accessing }
GtAwsCredentials >> load [
	self credentialFile exists
		ifFalse: [ self error: 'AWS credentials file doesn’t exist.' ].

	self credentialFile contents
		lines do: [ :aLine | 
			(aLine beginsWith: 'aws_access_key_id = ')
				ifTrue: [ accessKeyId := (aLine copyReplaceAll: 'aws_access_key_id = ' with: '') trim ].
			(aLine beginsWith: 'aws_secret_access_key = ')
				ifTrue: [ secretAccessKey := (aLine copyReplaceAll: 'aws_secret_access_key = ' with: '')
							trim ] ]
]

{ #category : #accessing }
GtAwsCredentials >> secretAccessKey [
	^ secretAccessKey
]

{ #category : #accessing }
GtAwsCredentials >> secretAccessKey: anObject [
	^ secretAccessKey := anObject
]
