Class {
	#name : #GtAwsS3BucketGroup,
	#superclass : #GtAwsGroup,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsS3BucketGroup >> gtBucketsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Buckets';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Modified at'
			text: #modifiedAt
			width: 180;
		column: 'In CF'
			icon: [ :aBucket | 
				aBucket lookupInCloudFormation
					ifNil: [ BrGlamorousVectorIcons transparent ]
					ifNotNil: [ :aValue | 
						aValue isAsyncPromise
							ifTrue: [ BrGlamorousVectorIcons refresh ]
							ifFalse: [ BrGlamorousVectorIcons accept ] ] ]
]
