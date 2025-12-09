Class {
	#name : 'REXLoader',
	#superclass : 'Object',
	#instVars : [
		'root',
		'repos',
		'repositoryFormat'
	],
	#category : 'GtRepositoryExploration-Model',
	#package : 'GtRepositoryExploration',
	#tag : 'Model'
}

{ #category : 'accessing' }
REXLoader class >> root: aFileReference repositories: repos [ 
	^self new
		root: aFileReference;
		repos: repos;
		yourself
]

{ #category : 'accessing' }
REXLoader >> cloneAll [
	repos do: [:repoString |
		(PureGitUrl with: (repositoryFormat format: {repoString})) cloneIn: root]
]

{ #category : 'as yet unclassified' }
REXLoader >> initialize [
	repositoryFormat := '{1}'
]

{ #category : 'accessing' }
REXLoader >> pullAll [
	root directories do: [:gitRepo |
		(PureGitRepository on: gitRepo) operations pull: #()]
]

{ #category : 'accessing' }
REXLoader >> repos: aCollection [
	repos := aCollection
]

{ #category : 'accessing' }
REXLoader >> repositoryFormat: aString [ 
	repositoryFormat := aString
]

{ #category : 'accessing' }
REXLoader >> root [
	^ root
]

{ #category : 'accessing' }
REXLoader >> root: aFileReference [ 
	root := aFileReference
]
