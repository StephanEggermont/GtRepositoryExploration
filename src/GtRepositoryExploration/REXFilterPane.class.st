Class {
	#name : 'REXFilterPane',
	#superclass : 'BrHorizontalPane',
	#instVars : [
		'choices',
		'announcer'
	],
	#category : 'GtRepositoryExploration-Model',
	#package : 'GtRepositoryExploration',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
REXFilterPane >> announcer: anObject [ 
	announcer := anObject
]

{ #category : 'as yet unclassified' }
REXFilterPane >> checkedBackground [
	<gtExample>
	<return: #Color>
	^ Color
		r: 0.71
		g: 0.87
		b: 1
]

{ #category : 'as yet unclassified' }
REXFilterPane >> choices: aCollection [ 
	choices := aCollection.
	self updateChoices
]

{ #category : 'as yet unclassified' }
REXFilterPane >> click: name [ 
	announcer announce: (REXUpdate visible: name)
]

{ #category : 'as yet unclassified' }
REXFilterPane >> initialize [
	choices := #().
	super initialize.
	self hMatchParent;
		vFitContent.
	self padding: (BlInsets all: 5).
]

{ #category : 'as yet unclassified' }
REXFilterPane >> uncheckedBackground [
	<gtExample>
	<return: #Color>
	^ Color white
]

{ #category : 'as yet unclassified' }
REXFilterPane >> updateChoices [
	self removeChildren.
	choices
		do: [ :extension | 
			| checkbox aLabel aShape aLook iconLook |
			aLabel := BrGlamorousLabelAptitude new.
			aShape := BrGlamorousButtonRectangularAptitude new.

			aLook := BrCheckboxAptitude new
					default: [ :aWidget | aWidget border: (BlBorder paint: Color gray width: 1) ];
					checked: [ :aWidget | 
						aWidget background: self checkedBackground.
						aLabel
							text: extension key;
							foreground: Color black;
							bold ];
					unchecked: [ :aWidget | 
						aWidget background: self uncheckedBackground.
						aLabel
							text: extension key;
							foreground: Color black;
							regular ].
			iconLook := iconLook := BrIconAptitude new
						icon: (BlElement new
								size: 10 @ 10;
								geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
								background: extension color).
			checkbox := BrCheckbox new aptitude: aLook + aLabel + aShape + iconLook.
			checkbox check.
			checkbox whenCheckedDo: [ self click: extension key ].
			checkbox whenUncheckedDo: [ self click: extension key ].
			self addChild: checkbox ]
]
