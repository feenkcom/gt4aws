Class {
	#name : #GtAwsServicesImporter,
	#superclass : #Object,
	#instVars : [
		'serviceFiles'
	],
	#category : #'Gt4Aws-Importer'
}

{ #category : #private }
GtAwsServicesImporter class >> cloneBotocore [

	IceRepositoryCreator
		fromUrl: 'https://github.com/boto/botocore.git'
		to: 'botocore' asFileReference.
]

{ #category : #private }
GtAwsServicesImporter class >> onBotocore [
	| serviceFiles |
	self cloneBotocore.

	serviceFiles := ('botocore' asFileReference / 'botocore' / 'data') directories
			collect: [ :aChild | aChild children first / 'service-2.json' ].

	^ self new serviceFiles: serviceFiles
]

{ #category : #private }
GtAwsServicesImporter class >> services [
	| botocoreDirectory serviceFiles |

	botocoreDirectory := 'botocore' asFileReference.
	botocoreDirectory exists ifFalse: [ self cloneBotocore ].
	serviceFiles := (botocoreDirectory / 'botocore' / 'data') directories
			collect: [ :aChild | aChild children first / 'service-2.json' ].
	^ self new 
		serviceFiles: serviceFiles;
		import.
]

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
