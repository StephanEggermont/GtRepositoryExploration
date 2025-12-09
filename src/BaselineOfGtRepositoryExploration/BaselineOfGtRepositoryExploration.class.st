Class {
	#name : 'BaselineOfGtRepositoryExploration',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGtRepositoryExploration',
	#package : 'BaselineOfGtRepositoryExploration'
}

{ #category : 'loading' }
BaselineOfGtRepositoryExploration class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'GtRepositoryExploration' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : 'baseline' }
BaselineOfGtRepositoryExploration >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtRepositoryExploration'
		]
]
