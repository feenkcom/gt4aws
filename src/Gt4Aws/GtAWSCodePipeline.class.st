Class {
	#name : #GtAWSCodePipeline,
	#superclass : #GtAwsEntityHolder,
	#category : 'Gt4Aws-Model'
}

{ #category : #'as yet unclassified' }
GtAWSCodePipeline >> entityId [
	^ 'AWS::CodePipeline::Pipeline'
]

{ #category : #'as yet unclassified' }
GtAWSCodePipeline >> entityName [
	^ 'Pipelines'
]

{ #category : #'as yet unclassified' }
GtAWSCodePipeline >> refreshEntities [
	^ self client codePipelineListPipelines
]

{ #category : #'as yet unclassified' }
GtAWSCodePipeline >> serviceName [
	^ 'AWS CodePipeline'
]

{ #category : #'as yet unclassified' }
GtAWSCodePipeline >> viewName [
	^ #gtPipelinesFor:
]
