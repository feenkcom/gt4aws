Class {
	#name : #GtAwsCloudwatchMaximumDataPoint,
	#superclass : #GtAwsObject,
	#instVars : [
		'timestamp',
		'maximum',
		'unit'
	],
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCloudwatchMaximumDataPoint class >> fromDictionary: aDict [
	^ self new
		timestamp: (aDict at: 'Timestamp');
		maximum: (aDict at: 'Maximum');
		unit: (aDict at: 'Unit')
]

{ #category : #accessing }
GtAwsCloudwatchMaximumDataPoint >> maximum [
	^ maximum
]

{ #category : #accessing }
GtAwsCloudwatchMaximumDataPoint >> maximum: anObject [
	maximum := anObject
]

{ #category : #accessing }
GtAwsCloudwatchMaximumDataPoint >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GtAwsCloudwatchMaximumDataPoint >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #accessing }
GtAwsCloudwatchMaximumDataPoint >> unit [
	^ unit
]

{ #category : #accessing }
GtAwsCloudwatchMaximumDataPoint >> unit: anObject [
	unit := anObject
]
