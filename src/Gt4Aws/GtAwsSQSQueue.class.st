Class {
	#name : #GtAwsSQSQueue,
	#superclass : #GtAwsObject,
	#instVars : [
		'url',
		'attributes'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsSQSQueue class >> lookupEndpoint [
	^ #sqsGetQueueAttributes:
]

{ #category : #accessing }
GtAwsSQSQueue class >> resourceType [
	^ 'AWS::SQS::Queue'
]

{ #category : #accessing }
GtAwsSQSQueue >> attributes [
	^ attributes
]

{ #category : #accessing }
GtAwsSQSQueue >> attributes: anObject [
	attributes := anObject
]

{ #category : #accessing }
GtAwsSQSQueue >> gtAttributesFor: aView [
	<gtView>
	^ aView forward
		title: 'Attributes';
		priority: 1;
		object: [ self attributes ];
		view: #gtLiveFor:
]

{ #category : #accessing }
GtAwsSQSQueue >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self url;
		nextPut: $)
]

{ #category : #accessing }
GtAwsSQSQueue >> url [
	^ url
]

{ #category : #accessing }
GtAwsSQSQueue >> url: anObject [
	url := anObject
]