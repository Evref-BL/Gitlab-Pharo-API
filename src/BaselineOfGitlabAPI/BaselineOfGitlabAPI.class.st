Class {
	#name : 'BaselineOfGitlabAPI',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGitlabAPI',
	#package : 'BaselineOfGitlabAPI'
}

{ #category : 'baselines' }
BaselineOfGitlabAPI >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfGitlabAPI >> defineDependencies: spec [
	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
]

{ #category : 'baselines' }
BaselineOfGitlabAPI >> defineGroups: spec [
]

{ #category : 'baselines' }
BaselineOfGitlabAPI >> definePackages: spec [

	spec
		package: 'GitlabAPI-Core'
]
