Class {
	#name : #GtAwsServiceImporter,
	#superclass : #Object,
	#instVars : [
		'serviceFile',
		'profile',
		'zone'
	],
	#category : #'Gt4Aws-Importer'
}

{ #category : #accessing }
GtAwsServiceImporter >> gtServiceFileFor: aView [
	<gtView>
	^ aView forward
		title: 'Service file';
		priority: 1;
		object: [ self serviceFile ];
		view: #gtContentsFor:
]

{ #category : #accessing }
GtAwsServiceImporter >> import [
	^ GtAwsService new
		file: self serviceFile;
		profile: self profile;
		zone: self zone;
		rawData: (STONJSON fromString: self serviceFile contents)
]

{ #category : #accessing }
GtAwsServiceImporter >> profile [
	^ profile
]

{ #category : #accessing }
GtAwsServiceImporter >> profile: anObject [
	profile := anObject
]

{ #category : #accessing }
GtAwsServiceImporter >> serviceFile [
	^ serviceFile
]

{ #category : #accessing }
GtAwsServiceImporter >> serviceFile: anObject [
	serviceFile := anObject
]

{ #category : #accessing }
GtAwsServiceImporter >> zone [
	^ zone
]

{ #category : #accessing }
GtAwsServiceImporter >> zone: anObject [
	zone := anObject
]
