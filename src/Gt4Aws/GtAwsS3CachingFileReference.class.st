Class {
	#name : #GtAwsS3CachingFileReference,
	#superclass : #GtAwsS3AbstractFileReference,
	#instVars : [
		'cacheFile',
		'size',
		'modificationTime'
	],
	#category : 'Gt4Aws-Model'
}

{ #category : #converting }
GtAwsS3CachingFileReference >> asFileReference [

	self ensureContents.
	^ cacheFile
]

{ #category : #converting }
GtAwsS3CachingFileReference >> asNonCachingS3FileReference [

	^ GtAwsS3FileReference s3Url: s3Url
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> binaryContents [

	self ensureContents.
	^ cacheFile binaryContents
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> cacheFile [
	| znUrl segments |

	cacheFile ifNotNil: [ ^ cacheFile ].
	znUrl := s3Url asZnUrl.
	segments := Array streamContents: [ :stream |
		stream
			nextPut: znUrl host;
			nextPutAll: znUrl segments ].
	^ cacheFile := self class s3CacheDirectory / (RelativePath withAll: segments) fullName
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> cacheFile: aFileReference [

	cacheFile := aFileReference
]

{ #category : #cache }
GtAwsS3CachingFileReference >> clearCache [

	cacheFile ifNotNil:
		[ cacheFile ensureDelete ].
	size := nil.
	modificationTime := nil.
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> contents [

	self ensureContents.
	^ cacheFile readStreamDo: [ :stream |
		stream encoder: ZnLossyUTF8Encoder new.
		stream upToEnd ].
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> ensureContents [

	self cacheFile exists ifTrue: [ ^ self ].
	self class s3CacheDirectory ensureCreateDirectory.
	GtAwsAmazonWebServices default s3Cp: self s3Url to: self cacheFile asAbsolute fullName.
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> modificationTime [

	^ modificationTime ifNil: [ modificationTime := super modificationTime ]
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> modificationTime: anObject [

	modificationTime := anObject asDateAndTime
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> size [ 

	^ size ifNil: 
		[ self ensureContents.
		size := cacheFile size ]
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> size: anInteger [

	size := anInteger
]
