Class {
	#name : 'REXExtension',
	#superclass : 'Object',
	#instVars : [
		'key',
		'number',
		'selected'
	],
	#category : 'GtRepositoryExploration-Model',
	#package : 'GtRepositoryExploration',
	#tag : 'Model'
}

{ #category : 'accessing' }
REXExtension class >> key: anObject number: aNumber selected: aBoolean [ 
	^self new
		key: anObject;
		number: aNumber;
		selected: aBoolean;
		yourself
]

{ #category : 'as yet unclassified' }
REXExtension >> changeSelected [
	selected := selected not
]

{ #category : 'accessing' }
REXExtension >> key [
	^ key
]

{ #category : 'accessing' }
REXExtension >> key: anObject [
	key := anObject
]

{ #category : 'accessing' }
REXExtension >> number [
	^ number
]

{ #category : 'accessing' }
REXExtension >> number: anObject [
	number := anObject
]

{ #category : 'accessing' }
REXExtension >> selected [
	^ selected
]

{ #category : 'accessing' }
REXExtension >> selected: anObject [
	selected := anObject
]
