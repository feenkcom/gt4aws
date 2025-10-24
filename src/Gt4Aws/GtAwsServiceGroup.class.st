Class {
	#name : #GtAwsServiceGroup,
	#superclass : #GtAwsGroup,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsServiceGroup >> gtServicesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Services';
		priority: 1;
		items: [ self items sorted: #name ascending ];
		column: 'Name' text: #name width: 250;
		column: '# of operations' text: [:aService | aService operations size] width: 100;
		column: 'Documentation' text: #documentation
]

{ #category : #accessing }
GtAwsServiceGroup >> serviceNamed: aName [
	^ self items
		detect: [ :aService | aService serviceId = aName ]
		ifNone: [ self error: 'No service named ' , aName , ' found' ]
]
