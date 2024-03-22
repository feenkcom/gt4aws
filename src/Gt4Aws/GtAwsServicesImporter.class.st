Class {
	#name : #GtAwsServicesImporter,
	#superclass : #Object,
	#instVars : [
		'serviceFiles'
	],
	#category : #'Gt4Aws-Importer'
}

{ #category : #accessing }
GtAwsServicesImporter >> gtServiceFilesFor: aView [
	<gtView>
	^ aView list
		title: 'Service files';
		priority: 1;
		items: [ self serviceFiles ]
]

{ #category : #accessing }
GtAwsServicesImporter >> import [
	^ GtAwsServiceGroup
		withAll: (self serviceFiles
			select: #exists
			thenCollect: [ :aFile | 
				GtAwsServiceImporter new
					serviceFile: aFile;
					import ])
]

{ #category : #accessing }
GtAwsServicesImporter >> serviceFiles [
	^ serviceFiles
]

{ #category : #accessing }
GtAwsServicesImporter >> serviceFiles: anObject [
	serviceFiles := anObject
]
