Class {
	#name : #GtAwsEc2InstanceGroup,
	#superclass : #GtAwsGroup,
	#category : 'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsEc2InstanceGroup >> gtInstancesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Instances';
		priority: 1;
		items: [ self items ];
		column: 'Id' text: #id;
		column: 'Type' text: #type;
		column: 'Launch Time' text: #launchTime;
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
