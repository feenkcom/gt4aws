Class {
	#name : #GtAwsS3AbstractFileReference,
	#superclass : #Object,
	#instVars : [
		'modificationTime',
		'parent',
		's3Url'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3AbstractFileReference class >> s3CacheDirectory [

	^ FileLocator imageDirectory / 's3Cache'.
]

{ #category : #'instance creation' }
GtAwsS3AbstractFileReference class >> s3Url: aS3Url [

	^ self new s3Url: aS3Url
]

{ #category : #'as yet unclassified' }
GtAwsS3AbstractFileReference >> / aString [

	^ self class s3Url:
		(s3Url asZnUrl addPathSegment: aString)
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> basename [
	<return: #String>
	| segments znUrl |

	znUrl := s3Url asZnUrl.
	segments := znUrl segments.
	segments ifNil: [ ^ znUrl host ].
	^ segments last = $/
		ifTrue: [ segments at: segments size - 1 ]
		ifFalse: [ segments last ]
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> basenameWithoutExtension [
	"Returns the base of the basename but without its extension"
	^self basename copyUpToLast: Path extensionDelimiter
]

{ #category : #'as yet unclassified' }
GtAwsS3AbstractFileReference >> beDirectory [

	s3Url last = $/ ifFalse:
		[ s3Url := s3Url, '/' ]
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> binaryContents [

	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> contents [

	^ self subclassResponsibility
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> contentsUtf8Lossy [

	^ self contents
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> filesAndFolders [
	^ GtAwsAmazonWebServices default s3ls: self s3Url
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> fullName [

	^ s3Url
]

{ #category : #'gt - extensions' }
GtAwsS3AbstractFileReference >> gtContentsFor: aView [
	<gtView>
	self isDirectory ifTrue: [ ^aView empty ].
	
	^ aView textEditor
		title: 'Contents';
		priority: 100;
		text: [ self contents ];
		actionUpdateButton.
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> gtDisplayOn: aStream [

	s3Url isNil ifTrue: [ ^ super printOn: aStream ].
	aStream
		<< self basename;
		<< ' @ ';
		print: self parent
]

{ #category : #'gt - extensions' }
GtAwsS3AbstractFileReference >> gtItemsFor: aView [
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
GtAwsS3AbstractFileReference >> isDirectory [

	^ s3Url last = $/
]

{ #category : #testing }
GtAwsS3AbstractFileReference >> isFile [

	^ s3Url last ~= $/
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> modificationTime [
	^ modificationTime
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> modificationTime: anObject [

	modificationTime := anObject asDateAndTime
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> parent [
	parent := nil.
	^ parent ifNil: [
		parent := (self class s3Url: s3Url asZnUrl parent)
			beDirectory;
			size: 0 ]
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> parent: aLwGtS3FileReference [

	parent := aLwGtS3FileReference
]

{ #category : #printing }
GtAwsS3AbstractFileReference >> printOn: aStream [

	s3Url ifNil: [ ^ super printOn: aStream ].
	aStream << s3Url
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> s3Host [

	^ s3Url asZnUrl host
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> s3Url [

	^ s3Url
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> s3Url: aStringOrZnUrl [

	s3Url := aStringOrZnUrl asString
]

{ #category : #accessing }
GtAwsS3AbstractFileReference >> size [ 

	^ self subclassResponsibility
]
