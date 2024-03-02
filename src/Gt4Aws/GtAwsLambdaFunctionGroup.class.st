Class {
	#name : #GtAwsLambdaFunctionGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsLambdaFunctionGroup >> gtFunctionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Functions';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'ARN' text: #arn;
		column: 'Description' text: #description;
		column: 'In CF'
			stencil: [ :aFunction | 
				aFunction lookupInCloudFormation
					ifNil: [ BrGlamorousVectorIcons transparent ]
					ifNotNil: [ BrGlamorousVectorIcons accept ] ]
			width: 40
]
