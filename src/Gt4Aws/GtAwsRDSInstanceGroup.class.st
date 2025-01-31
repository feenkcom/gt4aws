Class {
	#name : #GtAwsRDSInstanceGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsRDSInstanceGroup >> gtDatabasesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Databases';
		priority: 1;
		items: [self items];
		column: 'Name' text: #name;
		column: 'Instance class' text: #instanceClass;
		column: 'Status' text: #status
]
