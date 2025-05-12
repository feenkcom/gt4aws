Class {
	#name : #GtAwsAsgActivityGroup,
	#superclass : #GtAwsGroup,
	#category : #Gt4Aws
}

{ #category : #ui }
GtAwsAsgActivityGroup >> gtActivityFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Activities';
		priority: 10;
		items: [ self items ];
		column: 'Time' text: [ :item | item startTime ];
		column: 'Description' text: [ :item | item description ]
]
