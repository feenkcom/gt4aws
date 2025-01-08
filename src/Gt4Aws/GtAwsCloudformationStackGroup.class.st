Class {
	#name : #GtAwsCloudformationStackGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCloudformationStackGroup >> gtResourcesFor: aView [
	<gtView>
	^ aView forward
		title: 'Resources';
		priority: 2;
		object: [ self resources ];
		view: #gtResourcesFor:
]

{ #category : #accessing }
GtAwsCloudformationStackGroup >> gtStacksFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Stacks';
		priority: 1;
		items: [ self items ];
		column: 'Stack name' text: #name;
		column: 'Description' text: [ :each | each templateDescription ifNil: [ '' ] ];
		column: 'Status' text: #statusLabel
]

{ #category : #accessing }
GtAwsCloudformationStackGroup >> resources [
	^ GtAwsCloudFormationStackResourceGroup
		withAll: (self items flatCollect: [ :aStack | [ aStack resources ] on: Error do: [ {} ] ])
]
