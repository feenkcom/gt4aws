Class {
	#name : #GtAwsEc2TransitGatewayGroup,
	#superclass : #GtAwsGroup,
	#category : 'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsEc2TransitGatewayGroup >> gtTransitGatewaysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Transit gateways';
		priority: 1;
		items: [ self items ];
		column: 'ID' text: #id;
		column: 'ARN' text: #arn;
		column: 'Description' text: #description;
		column: 'Creation time' text: #creationTime
]
