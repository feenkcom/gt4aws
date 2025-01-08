Class {
	#name : #GtAwsEc2RouteTableGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsEc2RouteTableGroup >> gtRouteTablesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Route tables';
		priority: 1;
		items: [ self items ];
		column: 'ID' text: #id;
		column: 'VPC' text: #vpcId
]
