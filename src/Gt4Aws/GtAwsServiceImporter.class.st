Class {
	#name : #GtAwsServiceImporter,
	#superclass : #Object,
	#instVars : [
		'serviceFile'
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
		rawData: (STONJSON fromString: self serviceFile contents)
]

{ #category : #accessing }
GtAwsServiceImporter >> serviceFile [
	^ serviceFile
]

{ #category : #accessing }
GtAwsServiceImporter >> serviceFile: anObject [
	serviceFile := anObject
]
