Class {
	#name : #GtAwsS3FileReference,
	#superclass : #Object,
	#instVars : [
		's3DirectoryUrl',
		'basename',
		'size',
		'modificationTime',
		'parent'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3FileReference >> basename [
	<return: #String>

	^ basename
]

{ #category : #accessing }
GtAwsS3FileReference >> basename: aString [

	basename := aString
]

{ #category : #accessing }
GtAwsS3FileReference >> basenameWithoutExtension [
	"Returns the base of the basename but without its extension"
	^self basename copyUpToLast: Path extensionDelimiter
]

{ #category : #accessing }
GtAwsS3FileReference >> binaryContents [
	| tmpFile |

	tmpFile := FileReference newTempFilePrefix: 'GtAwsS3FileReference-' suffix: '.dat'.
	^ [ GtAwsAmazonWebServices default s3Cp: self s3Url to: tmpFile asAbsolute fullName.
		tmpFile gtBinaryContents ]
			ensure: [ tmpFile ensureDelete ].
]

{ #category : #accessing }
GtAwsS3FileReference >> contents [
	| tmpFile |

	tmpFile := FileReference newTempFilePrefix: 'GtAwsS3FileReference-' suffix: '.dat'.
	^ [ GtAwsAmazonWebServices default s3Cp: self s3Url to: tmpFile asAbsolute fullName.
		tmpFile contents ]
			ensure: [ tmpFile ensureDelete ].
]

{ #category : #accessing }
GtAwsS3FileReference >> filesAndFolders [
	^ GtAwsAmazonWebServices default s3ls: self s3Url
]

{ #category : #accessing }
GtAwsS3FileReference >> fullName [
	^ self s3DirectoryUrl, self basename
]

{ #category : #'gt - extensions' }
GtAwsS3FileReference >> gtContentsFor: aView [
	<gtView>
	self isDirectory ifTrue: [ ^aView empty ].
	
	^ aView textEditor
		title: 'Contents';
		priority: 100;
		text: [ self contents ];
		actionUpdateButton.
]

{ #category : #accessing }
GtAwsS3FileReference >> gtDisplayOn: aStream [

	(s3DirectoryUrl isNil or: [ basename isNil ])
		ifTrue: [ ^ super printOn: aStream ].
	aStream
		<< basename;
		<< ' @ ';
		<< s3DirectoryUrl
]

{ #category : #'gt - extensions' }
GtAwsS3FileReference >> gtItemsFor: aView [
	<gtView>
	self isDirectory
		ifFalse: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Items' translated;
		priority: 10;
		items: [ self filesAndFolders ];
		column: 'Icon' translated 
			icon: [ :each | 
				each isDirectory
					ifTrue: [ BrGlamorousIcons folder ]
					ifFalse: [ BrGlamorousIcons file ] ];
		column: 'Name' translated text: [ :each | 
			each basename ];
		column: 'Size' translated
			text: [ :each | 
				[ each isDirectory 
					ifTrue: [ '--' ]
					ifFalse: [ each size humanReadableSIByteSize ] ]
				on: FileException, FileSystemError
				do: [ :anException | anException return: '' ] ]
			width: 100;
		column: 'Creation' translated
			text: [ :each | 
				each modificationTime 
					ifNil: [ '--' ]
					ifNotNil: [ :aDateAndTime | 
						String
							streamContents: [ :s | 
								aDateAndTime printYMDOn: s.
								s nextPut: Character space.
								aDateAndTime printHMSOn: s ] ]  ]
			width: 150;
		actionUpdateButton
]

{ #category : #testing }
GtAwsS3FileReference >> isDirectory [

	^ basename last = $/
]

{ #category : #testing }
GtAwsS3FileReference >> isFile [

	^ basename last ~= $/
]

{ #category : #accessing }
GtAwsS3FileReference >> modificationTime [
	^ modificationTime
]

{ #category : #accessing }
GtAwsS3FileReference >> modificationTime: anObject [

	modificationTime := anObject asDateAndTime
]

{ #category : #accessing }
GtAwsS3FileReference >> parent [
	^ parent ifNil: [
		parent := GtAwsS3FileReference new
			s3DirectoryUrl: (self s3DirectoryUrl allButLast
				copyUpToLast: $/), '/';
			basename: (self s3DirectoryUrl 
				copyFrom: (self s3DirectoryUrl allButLast lastIndexOf:  $/) + 1
				to: self s3DirectoryUrl size);
			size: 0 ]
]

{ #category : #accessing }
GtAwsS3FileReference >> parent: aParent [
	parent := aParent
]

{ #category : #printing }
GtAwsS3FileReference >> printOn: aStream [

	(s3DirectoryUrl isNil or: [ basename isNil ]) ifTrue:
		[ ^ super printOn: aStream ].
	aStream
		<< s3DirectoryUrl;
		<< basename.
]

{ #category : #accessing }
GtAwsS3FileReference >> s3DirectoryUrl [
	<return: #String>
	
	^ s3DirectoryUrl
]

{ #category : #accessing }
GtAwsS3FileReference >> s3DirectoryUrl: aString [

	self assert: [ aString beginsWith: 's3://' ].

	s3DirectoryUrl := aString last = $/
		ifTrue: [ aString ]
		ifFalse: [ aString, '/' ]
]

{ #category : #accessing }
GtAwsS3FileReference >> s3Url [

	^ s3DirectoryUrl, basename
]

{ #category : #accessing }
GtAwsS3FileReference >> size [ 

	^ size
]

{ #category : #accessing }
GtAwsS3FileReference >> size: anObject [
	size := anObject
]
