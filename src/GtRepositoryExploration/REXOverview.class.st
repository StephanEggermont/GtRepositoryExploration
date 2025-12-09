Class {
	#name : 'REXOverview',
	#superclass : 'Object',
	#instVars : [
		'root',
		'files',
		'extensions'
	],
	#category : 'GtRepositoryExploration-Model',
	#package : 'GtRepositoryExploration',
	#tag : 'Model'
}

{ #category : 'accessing' }
REXOverview class >> on: aFileReference [
	^self new
		root: aFileReference;
		yourself
]

{ #category : 'accessing' }
REXOverview >> calculateExtensions [
	| extensionsBag |
	extensionsBag := Bag new.
	files do: [ :file | extensionsBag add: file extension ].
	extensions := OrderedCollection new.
	extensionsBag
			sortedCounts do: [ :association | 
				extensions add:(
				REXExtension
					key: association value 
					number: association key 
					selected: true) ]
]

{ #category : 'as yet unclassified' }
REXOverview >> changeSelectionOf: anExtension [ 
	anExtension changeSelected
]

{ #category : 'as yet unclassified' }
REXOverview >> extensions [
	^extensions
]

{ #category : 'as yet unclassified' }
REXOverview >> gtExtensionsFor: aView [
	<gtView>
	^aView columnedList
		title: 'File extensions';
		priority: 10;
		items: [self extensions];
		column: 'Type' text: #key;
		column: '#' text: #number;
		column: 'Include'
			stencil: [ :anExtension | 
				| checkbox |
				checkbox := BrCheckbox new aptitude: BrGlamorousCheckboxAptitude.
				anExtension selected ifTrue: [ checkbox check ].
				checkbox
					action: [ :aButton :aTab | 
						self changeSelectionOf: anExtension.
						checkbox phlow fireViewUpdateWish ].
				checkbox ]
]

{ #category : 'accessing' }
REXOverview >> loadAll [
	files := root allFiles.
	self calculateExtensions
]

{ #category : 'accessing' }
REXOverview >> root: aFileReference [ 
	root := aFileReference
]
