Class {
	#name : 'REXOverview',
	#superclass : 'Object',
	#instVars : [
		'root',
		'files',
		'extensions',
		'colorMap',
		'announcer',
		'pane',
		'filterPane'
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

{ #category : 'as yet unclassified' }
REXOverview >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'as yet unclassified' }
REXOverview >> builder [
	| builder |
	builder := GtNestedTreeBuilder new
			data: (root asFileReference allFiles
					select: [ :each | self visibleExtensions includes: each extension ]);
			groupBy: [ :aFile | (aFile relativeTo: root asFileReference) asPath segments first ];
			weight: [ :aFile | aFile size max: 1000 ];
			build.
	^ {builder}
]

{ #category : 'as yet unclassified' }
REXOverview >> calculateColors [
	|wheel|
	wheel := (Color wheel: self selectedExtensions size) collect: [:each | each alpha: 0.4].
	colorMap := Dictionary newFromKeys: (self selectedExtensions collect: [:ext | ext key]) andValues: wheel.
	extensions do: [:ext | 
		colorMap at: ext key ifPresent: [:found | ext color: found ] 
			ifAbsent: [ext color: Color white]]
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
	anExtension changeSelected.
	self calculateColors.
	filterPane ifNotNil: [filterPane choices: self selectedExtensions].
		pane ifNotNil: [
			pane children second removeFromParent.
			pane addChild: self treeMap asElement].
	self announcer announce: (REXUpdate new extension: anExtension).
]

{ #category : 'as yet unclassified' }
REXOverview >> colorForType: anObject [
	^colorMap at: anObject ifAbsent: [Color red].
]

{ #category : 'as yet unclassified' }
REXOverview >> containerContext: aNodeContext parent: anElement [
	aNodeContext level = 2
		ifTrue: [ anElement
				addChild: (BrLabel new
						text: aNodeContext model name;
						aptitude: (BrGlamorousLabelAptitude new
								fontSize: 12;
								foreground: Color blue);
						constraintsDo: [ :c | c ignoreByLayout ]) ].
	anElement
		border: (BlBorder paint: (Color gray alpha: 0.7 / aNodeContext level) width: 1).
	^ anElement padding: (BlInsets all: 1)
]

{ #category : 'as yet unclassified' }
REXOverview >> extensions [
	^extensions
]

{ #category : 'as yet unclassified' }
REXOverview >> filterPane [
	filterPane ifNil: [filterPane := REXFilterPane new
		announcer: self announcer
		yourself].
	filterPane choices: self selectedExtensions.
	^filterPane
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
		column: 'Visible' text: #visible;
		column: 'Color' stencil: [ :anExtension |
			BlElement new 
				size: 12@12;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
				background: anExtension color];
		updateWhen: REXUpdate in: [self announcer];
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

{ #category : 'as yet unclassified' }
REXOverview >> gtTsTreemapFor: aView [
	<gtView>
	^ aView forward
		title: 'TreeMap';
		priority: 20;
		object: [ self pane ];
		updateWhen: REXUpdate in: [self announcer];
		view: #gtLiveFor:
]

{ #category : 'as yet unclassified' }
REXOverview >> initialize [
	colorMap := Dictionary new.
	self announcer when: REXUpdate send: #update: to: self
]

{ #category : 'as yet unclassified' }
REXOverview >> leafElementParent: anElement context: aLeafContext [
	| isGtExample isTest |
	isTest := aLeafContext model item name matches: '*test*'.
	isGtExample := false.
	anElement
		border: (BlBorder paint: (Color gray alpha: 0.5 / aLeafContext level) width: 1);
		when: BlClickEvent do: [ :aClickEvent |
					(aClickEvent modifiers isPrimaryModifier "ctrl-click")
					ifFalse: [aClickEvent consumed: true.
						aClickEvent currentTarget phlow spawnObject: aLeafContext model item]].
	  anElement addAptitude: (BrWithExplicitContextMenuAptitude new
            stencil: [ | aMenu |
                aMenu := BrMenuExplicit new.
                aMenu
                    stencil: [ BrVerticalPane new
                            fitContent;
                            padding: (BlInsets all: 15);
                            addChild: (BlBasicExamples new circle asScalableElement size: 100 @ 100);
                            when: BlClickEvent
                                do: [ :aBlClickEvent | 
                                    aBlClickEvent consumed: true.
                                    aMenu hide ] ].
                aMenu ]).
	^ anElement
		background: (isTest
				ifTrue: [ Color yellow alpha: 0.4 ]
				ifFalse: [ self colorForType: aLeafContext model item extension])
]

{ #category : 'accessing' }
REXOverview >> loadAll [
	files := root allFiles.
	self calculateExtensions
]

{ #category : 'as yet unclassified' }
REXOverview >> pane [
	pane ifNil: [pane := BrVerticalPane new
		matchParent;
		addChild: self filterPane;
		addChild: self treeMap asElement].
	^pane
]

{ #category : 'accessing' }
REXOverview >> root: aFileReference [ 
	root := aFileReference
]

{ #category : 'as yet unclassified' }
REXOverview >> selectedExtensions [
	^extensions select: [:each | each selected] 
]

{ #category : 'as yet unclassified' }
REXOverview >> treeMap [
	<gtExample>
	^ GtNestedRectangleTreeMap new
		roots: self builder;
		leaves: [ :aNode | aNode leaves ];
		deep: [ :aNode | aNode nodes ];
		leavesSize: [ :aNode | aNode weight ];
		containerElement: [ :anElement :aNodeContext | self containerContext: aNodeContext parent: anElement ];
		leafElement: [ :anElement :aLeafContext | self leafElementParent: anElement context: aLeafContext ]
]

{ #category : 'as yet unclassified' }
REXOverview >> update: anUpdateEvent [
	anUpdateEvent visible ifNotNil: [ |ext|
		ext := extensions detect: [:e | e key = anUpdateEvent visible] . 
		ext visible: ext visible not.
		pane ifNotNil: [
			pane children second removeFromParent.
			pane addChild: self treeMap asElement]]
]

{ #category : 'as yet unclassified' }
REXOverview >> visibleExtensions [
	^extensions select: [:each | (each selected) and: (each visible = true)] thenCollect: [:each | each key]
]
