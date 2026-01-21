"
The intention is that GtAwsMultiRegionAsgGroup eventually provides the ability to control the state of AWS ASGs that exist in multiple regions.  For now, it simply retrieves the description.
"
Class {
	#name : #GtAwsMultiRegionAsgGroup,
	#superclass : #GtAwsGroup,
	#category : #'Gt4Aws-Model'
}

{ #category : #accessing }
GtAwsMultiRegionAsgGroup class >> leJsonV4Name [

	^ #GtAwsMultiRegionAsgGroup
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> activeCoreCount [
	"Answer the number of cores currently running in the receiver"

	^ self sumNumbers: #activeCoreCount
]

{ #category : #enumerating }
GtAwsMultiRegionAsgGroup >> allSatisfy: aBlock [

	"Evaluate aBlock with the elements of the receiver.
	If aBlock returns false for any element return false.
	Otherwise return true."

	"(#(1 2) allSatisfy: [ :each | each even ]) >>> false"
	"(#(2 4) allSatisfy: [ :each | each even ]) >>> true"

	"('hello' allSatisfy: #isLetter) >>> true"
	"('hello!' allSatisfy: #isLetter) >>> false"

	"((3 to: 8 by: 2) allSatisfy: #isPrime) >>> true"
	"((3 to: 9 by: 2) allSatisfy: #isPrime) >>> false"

	"(#() allSatisfy: [false]) >>> true"

	self do: [ :each | (aBlock value: each) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> atRegionName: aString [

	^ self detect: [ :each |
		each regionName = aString ]
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> atRegionName: aString put: aGtAwsAutoScalingGroupDescription [
	| itemIndex |

	itemIndex := self 
		detectIndex: [ :each | each regionName = aString ]
		ifNone: [ ^ self add: aGtAwsAutoScalingGroupDescription ].
	^ self items
		at: itemIndex
		put: aGtAwsAutoScalingGroupDescription
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> capacityInService [

	^ self sumNumbers: #capacityInService
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> coreCount [
	"Answer the number of cores currently available"

	^ self sumNumbers: #coreCount
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> coreCountInService [
	"Answer the number of cores currently available."

	^ self sumNumbers: #coreCountInService
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> coreCountTerminating [
	"Answer the number of cores currently available."

	^ self sumNumbers: #coreCountTerminating
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> desiredCapacity [

	^ self sumNumbers: #desiredCapacity
]

{ #category : #enumerating }
GtAwsMultiRegionAsgGroup >> inject: thisValue into: binaryBlock [
	"Accumulate a running value associated with evaluating the argument, binaryBlock, with the current value of the argument, thisValue, and the receiver as block arguments."
	"Look at Collection>>reduce: for a related method."

	"(#(2r101 2r11 2r1000) inject: 0 into: [ :acc :each | acc bitXor: each ]) >>> 2r1110"

	"(#(10 20 30) inject: 0 into: [ :sum :each | sum + each ]) >>> 60"
	"But use sum or sum: instead!"
	"#(10 20 30) sum >>> 60"

	"(#(10 20 30) inject: OrderedCollection new into: [ :a :e | a add: (e + 1). a ])
		>>> #(11 21 31) asOrderedCollection"
	"But use collect: or collect:as: instead!"
	"(#(10 20 30) collect: [:e| e+1]) >>> #(11 21 31)"

	| nextValue |
	nextValue := thisValue.
	self do: [:each | nextValue := binaryBlock value: nextValue value: each].
	^nextValue
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> instanceCount [
	"Answer the number of instances returned in the description."

	^ self sumNumbers: #instanceCount
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> instances [
	"Answer the instances currently running in the ASG."

	^ self flatCollect: #instances
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> instancesInService [
	"Answer the instances currently running in the ASG."

	^ self flatCollect: #instancesInService
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> instancesTerminating [
	"Answer the instances currently running in the ASG."

	^ self flatCollect: #instancesTerminating
]

{ #category : #testing }
GtAwsMultiRegionAsgGroup >> isIdle [

	^ self allSatisfy: #isIdle
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> preTerminatingCount [
	"Answer the number of instances that are either starting or running."

	^ self sumNumbers: #preTerminatingCount
]

{ #category : #accessing }
GtAwsMultiRegionAsgGroup >> preTerminatingInstances [
	"Answer the instances currently running in the ASG."

	^ self flatCollect: #preTerminatingInstances
]

{ #category : #enumerating }
GtAwsMultiRegionAsgGroup >> sumNumbers: aBlock [
	"This is implemented using a variant of the normal inject:into: pattern
	that is specific to handling numbers. aBlock is expected to return a number
	for every element in the collection.

	Different from the sum: implementation, the default value is zero. While sum: is
	more general, sumNumbers: is meant to support the most often encountered use case of
	dealing with numbers."

	"(#(1 -2 4) sumNumbers: #abs) >>> 7"

	"(#() sumNumbers: #abs) >>> 0"

	^ self
		inject: 0
		into: [ :sum :each |  sum + (aBlock value: each) ]
]
