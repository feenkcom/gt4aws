Class {
	#name : #GtAwsEc2InstanceTypesCommand,
	#superclass : #GtAwsEc2Command,
	#category : #'Gt4Aws-Commands'
}

{ #category : #initialization }
GtAwsEc2InstanceTypesCommand >> initialize [

	super initialize.
	arguments operation: 'describe-instance-types'.
]

{ #category : #'as yet unclassified' }
GtAwsEc2InstanceTypesCommand >> process: aString [
	| result typesArray |

	typesArray := STONJSON fromString: aString trimBoth.
	result := Dictionary new.
	(typesArray  at: #InstanceTypes) do: [ :each | 
		result
			at: (each at: #InstanceType)
			put: (GtAwsInstanceType jsonObject: each) ].
	^ result
]
