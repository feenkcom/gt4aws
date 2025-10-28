Class {
	#name : #GtAwsIAMRoleGroup,
	#superclass : #GtAwsGroup,
	#category : 'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsIAMRoleGroup >> gtRolesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Roles';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #roleName;
		column: 'ID' text: #roleId;
		column: 'Create time' text: #createDate
]
