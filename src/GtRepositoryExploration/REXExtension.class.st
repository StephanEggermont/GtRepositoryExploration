Class {
	#name : 'REXExtension',
	#superclass : 'Object',
	#instVars : [
		'key',
		'number',
		'selected',
		'visible',
		'color'
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
		visible: true;
		yourself
]

{ #category : 'as yet unclassified' }
REXExtension >> changeSelected [
	selected := selected not
]

{ #category : 'accessing' }
REXExtension >> color [
	^ color ifNil: [Color white]
]

{ #category : 'accessing' }
REXExtension >> color: anObject [
	color := anObject
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

{ #category : 'accessing' }
REXExtension >> visible [
	^ visible
]

{ #category : 'accessing' }
REXExtension >> visible: anObject [
	visible := anObject
]
