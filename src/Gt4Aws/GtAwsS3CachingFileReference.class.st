Class {
	#name : #GtAwsS3CachingFileReference,
	#superclass : #GtAwsS3AbstractFileReference,
	#instVars : [
		'cacheFile',
		'size'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #converting }
GtAwsS3CachingFileReference >> asFileReference [

	(cacheFile isNil or: [ cacheFile exists not ]) ifTrue:
		[ self downloadContents ].
	^ cacheFile
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> binaryContents [

	(cacheFile isNil or: [ cacheFile exists not ]) ifTrue:
		[ self downloadContents ].
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
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> contents [

	(cacheFile isNil or: [ cacheFile exists not ]) ifTrue:
		[ self downloadContents ].
	^ cacheFile readStreamDo: [ :stream |
		stream encoder: ZnLossyUTF8Encoder new.
		stream upToEnd ].
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> downloadContents [

	self cacheFile exists ifTrue: [ ^ self ].
	self class s3CacheDirectory ensureCreateDirectory.
	GtAwsAmazonWebServices default s3Cp: self s3Url to: self cacheFile asAbsolute fullName.
]

{ #category : #accessing }
GtAwsS3CachingFileReference >> size: anInteger [

	size := anInteger
]
