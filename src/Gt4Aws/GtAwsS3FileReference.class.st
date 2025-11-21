Class {
	#name : #GtAwsS3FileReference,
	#superclass : #GtAwsS3AbstractFileReference,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3FileReference >> binaryContents [
	| tmpFile binaryContents |

	tmpFile := FileReference newTempFilePrefix: self class name asString suffix: '.tmp'.
	GtAwsAmazonWebServices default s3Cp: self s3Url to: tmpFile asAbsolute fullName.
	binaryContents := tmpFile binaryContents.
	tmpFile delete.
	^ binaryContents
]

{ #category : #accessing }
GtAwsS3FileReference >> contents [
	| tmpFile contents |

	tmpFile := FileReference newTempFilePrefix: self class name asString suffix: '.tmp'.
	GtAwsAmazonWebServices default s3Cp: self s3Url to: tmpFile asAbsolute fullName.
	contents := tmpFile readStreamDo: [ :stream |
			stream encoder: ZnLossyUTF8Encoder new.
			stream upToEnd ].
	tmpFile delete.
	^ contents.
]

{ #category : #accessing }
GtAwsS3FileReference >> size [ 
	| tmpFile fileSize |

	self isDirectory ifTrue: [ ^ 0 ].
	tmpFile := FileReference newTempFilePrefix: self class name asString suffix: '.tmp'.
	GtAwsAmazonWebServices default s3Cp: self s3Url to: tmpFile asAbsolute fullName.
	fileSize := tmpFile size.
	tmpFile delete.
	fileSize.
]
