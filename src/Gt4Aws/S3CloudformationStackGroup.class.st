Class {
	#name : #S3CloudformationStackGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
S3CloudformationStackGroup >> gtStacksFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Stacks';
		priority: 1;
		items: [ self items ];
		column: 'Stack name' text: #name;
		column: 'Description' text: [ :each | each templateDescription ifNil: [ '' ] ];
		column: 'Status' text: #statusLabel
]
