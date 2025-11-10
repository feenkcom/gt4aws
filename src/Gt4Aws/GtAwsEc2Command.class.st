Class {
	#name : #GtAwsEc2Command,
	#superclass : #GtAwsCommand,
	#instVars : [
		'key'
	],
	#category : #'Gt4Aws-Commands'
}

{ #category : #initialization }
GtAwsEc2Command >> initialize [

	super initialize.
	arguments endpointPrefix: 'ec2'.
]
