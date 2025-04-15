Class {
	#name : #GtAwsMultiRegionAsgManager,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'regionManagers',
		'groupName',
		'groupDescriptions',
		'announcer',
		'mutex'
	],
	#category : #'Gt4Aws-Management'
}

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> addRegionName: aString [

	mutex criticalReleasingOnError:
		[ regionManagers
			at: aString
			ifPresent: [ :regionManager |
				self error: aString asString, ' already registered' ]
			ifAbsentPut: 	
				[ self newRegionManagerFor: aString ] ]
]

{ #category : #announcer }
GtAwsMultiRegionAsgManager >> announcer [
	<return: #Announcer>

	^ announcer
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> descriptionState [
	"Answer the effective state of the receiver's descriptions.
	This is the least confident value from the individual regions."
	| states index statesRanking |

	"Iterating over the #values takes a copy of the dictionary,
	removing the need to use the mutex."
	states := regionManagers values collect: #descriptionState.
	states ifEmpty: [ ^ #none ].
	index := SmallInteger maxVal.
	statesRanking := #(none stopped stale current).
	states do: [ :state |
		index := index min: (statesRanking indexOf: state) ].
	^ statesRanking at: (index max: 1)
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> groupDescriptions [
	"Answer the group descriptions.
	Keep the description cache alive for each individual region."

	"Iterating over the #values takes a copy of the dictionary,
	removing the need to use the mutex."
	regionManagers values do: [ :regionManager |
		regionManager descriptionCache keepAlive ].
	^ groupDescriptions
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> groupName [
	^groupName
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> groupName: anObject [
	groupName := anObject
]

{ #category : #testing }
GtAwsMultiRegionAsgManager >> hasDescriptions [

	^ groupDescriptions size = regionManagers size
]

{ #category : #'as yet unclassified' }
GtAwsMultiRegionAsgManager >> initialize [

	super initialize.
	regionManagers := Dictionary new.
	groupDescriptions := GtAwsMultiRegionAsgGroup new.
	announcer := Announcer new.
	mutex := Mutex new.
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> isIdle [
	"Answer a boolean indicating if all regions are idle.
	Note that this will wait for the description to appear.  Status messages should use the description directly."

	"Iterating over the #values takes a copy of the dictionary,
	removing the need to use the mutex."
	^ regionManagers values allSatisfy: #isIdle
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> lastRetrievedTime [
	"Answer the earliest lastRetrievedTime from the regionManagers"

	"Iterating over the #values takes a copy of the dictionary,
	removing the need to use the mutex."
	^ (regionManagers values collect: #lastRetrievedTime)
		ifEmpty: [ DateAndTime epoch]
		ifNotEmpty: [ :collection | collection min ]
]

{ #category : #private }
GtAwsMultiRegionAsgManager >> newRegionManagerFor: aString [
	| newRegion |

	newRegion := GtAwsAutoScalingGroupManager new
			regionName: aString;
			groupName: groupName.
	newRegion descriptionCache
		when: GtTimeCachedObjectAnnouncement
		send: #onRegionDescriptionUpdated:
		to: self.
	^ newRegion
]

{ #category : #private }
GtAwsMultiRegionAsgManager >> onRegionDescriptionUpdated: aGtTimeCachedObjectAnnouncement [
	| description |

	description := aGtTimeCachedObjectAnnouncement newValue.
	description ifNil: [ ^ self ].
	mutex criticalReleasingOnError:
		[ groupDescriptions
			atRegionName: description regionName
			put: description ].
	self announce: (GtAwsMultiRegionDescriptionUpdatedAnnouncement new
		manager: self).
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> regionManagerAt: aRegionName [

	^ regionManagers at: aRegionName
]

{ #category : #accessing }
GtAwsMultiRegionAsgManager >> removeRegionName: aString [

	^ mutex criticalReleasingOnError: [ regionManagers removeKey: aString ]
]
