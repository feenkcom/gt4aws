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
			icon: [ :anInstance | 
				anInstance lookupInCloudFormation
					ifNil: [ BrGlamorousVectorIcons transparent ]
					ifNotNil: [ :aValue | 
						aValue isAsyncPromise
							ifTrue: [ BrGlamorousVectorIcons refresh ]
							ifFalse: [ BrGlamorousVectorIcons accept ] ] ]
			width: 40
]
