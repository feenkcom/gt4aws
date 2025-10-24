Class {
	#name : #GtAwsGroup,
	#superclass : #Object,
	#traits : 'TGtTypedGroupWithItems',
	#classTraits : 'TGtTypedGroupWithItems classTrait',
	#category : 'Gt4Aws-Model'
}

{ #category : #private }
GtAwsGroup >> items: aSequenceableCollection [
	"For serialisation only"
	
	items := aSequenceableCollection
]
