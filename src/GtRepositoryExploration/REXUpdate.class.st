Class {
	#name : 'REXUpdate',
	#superclass : 'Announcement',
	#instVars : [
		'extension',
		'visible'
	],
	#category : 'GtRepositoryExploration-Model',
	#package : 'GtRepositoryExploration',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
REXUpdate class >> on: anExtension [
	^self new
		extension: anExtension;
		yourself
]

{ #category : 'as yet unclassified' }
REXUpdate class >> visible: anExtension [
	^self new
		extension: anExtension;
		visible: anExtension;
		yourself
]

{ #category : 'accessing' }
REXUpdate >> extension [
	^ extension
]

{ #category : 'accessing' }
REXUpdate >> extension: anObject [
	extension := anObject
]

{ #category : 'accessing' }
REXUpdate >> visible [
	^ visible
]

{ #category : 'accessing' }
REXUpdate >> visible: anObject [
	visible := anObject
]
