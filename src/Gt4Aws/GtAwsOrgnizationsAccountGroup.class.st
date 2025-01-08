Class {
	#name : #GtAwsOrgnizationsAccountGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsOrgnizationsAccountGroup >> gtAccountsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Accounts';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'E-Mail' text: #email;
		column: 'ID' text: #id;
		column: 'ARN' text: #arn;
		column: 'Status' text: #status;
		column: 'Joined on' text: #joinedTimestamp
]
