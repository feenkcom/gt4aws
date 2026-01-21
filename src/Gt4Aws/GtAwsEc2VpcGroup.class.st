Class {
	#name : #GtAwsEc2VpcGroup,
	#superclass : #GtAwsGroup,
	#category : 'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsEc2VpcGroup >> gtVpcsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'VPCs';
		priority: 1;
		items: [ self items ];
		column: 'ID' text: #id;
		column: 'CIDR block' text: #cidrBlock;
		column: 'Default' text: #isDefault;
		column: 'Instance tenancy' text: #instanceTenancy;
		column: 'State' text: #state
]
