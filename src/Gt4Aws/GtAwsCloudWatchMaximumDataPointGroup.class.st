Class {
	#name : #GtAwsCloudWatchMaximumDataPointGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsCloudWatchMaximumDataPointGroup >> average [
	^ (self items collect: #maximum) average
]

{ #category : #accessing }
GtAwsCloudWatchMaximumDataPointGroup >> gtViewCpuFor: aView [
	<gtView>
	^ aView columnedList
		title: 'CPU Usage';
		priority: 1;
		items: [ self items ];
		column: 'Timestamp' text: #timestamp;
		column: 'Percentage' text: #maximum
]

{ #category : #accessing }
GtAwsCloudWatchMaximumDataPointGroup >> gtViewSparklineFor: aView [
	<gtView>
	^ aView explicit
		title: 'Sparkline';
		priority: 2;
		stencil: [ (GtHorizontalSparklineStencil new
				values: (self items withIndexCollect: [ :aValue :i | aValue maximum -> i ]);
				color: BrGlamorousColors hoveredButtonTextColor) asElement height: 100 ]
]

{ #category : #accessing }
GtAwsCloudWatchMaximumDataPointGroup >> maximum [
	^ self items max: #maximum
]
