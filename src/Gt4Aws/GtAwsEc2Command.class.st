Class {
	#name : #GtAwsEc2Command,
	#superclass : #GtAwsCommand,
	#instVars : [
		'key'
	],
	#category : #'Gt4Aws-Commands'
}

{ #category : #'as yet unclassified' }
GtAwsEc2Command >> initialize [

	super initialize.
	arguments endpointPrefix: 'ec2'.
]
