Class {
	#name : #GtAwsCPPipelineGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAwsCPPipelineGroup >> gtPipelinesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pipelines';
		priority: 1;
		items: [ self items ];
		column: 'Name' text: #name;
		column: 'Version' text: #version width: 100;
		column: 'Created' text: #created;
		column: 'Updated' text: #updated
]
