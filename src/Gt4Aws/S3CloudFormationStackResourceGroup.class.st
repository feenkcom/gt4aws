Class {
	#name : #S3CloudFormationStackResourceGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
S3CloudFormationStackResourceGroup >> gtResourcesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Resources';
		priority: 1;
		items: [ self items ];
		column: 'Logical Resource ID' text: #logicalResourceId;
		column: 'Physical Resource ID' text: #physicalResourceId;
		column: 'Resource Type' text: #resourceType;
		column: 'Status' text: #statusLabel
]
