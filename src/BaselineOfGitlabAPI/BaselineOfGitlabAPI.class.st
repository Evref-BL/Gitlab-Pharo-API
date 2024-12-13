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
		
	spec
    baseline: 'Mocketry'
    with: [ spec repository: 'github://dionisiydk/Mocketry' ]
]

{ #category : 'baselines' }
BaselineOfGitlabAPI >> defineGroups: spec [
]

{ #category : 'baselines' }
BaselineOfGitlabAPI >> definePackages: spec [

	spec
		package: 'GitlabAPI-Core'.
		
	spec package: 'GitlabAPI-Projects' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Projects-Tests' with: [ spec requires: #('GitlabAPI-Projects' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Branches' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Branches-Tests' with: [ spec requires: #('GitlabAPI-Branches' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Commits' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Commits-Tests' with: [ spec requires: #('GitlabAPI-Commits' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Discussions' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Discussions-Tests' with: [ spec requires: #('GitlabAPI-Discussions' 'Mocketry') ].
	
	spec package: 'GitlabAPI-MergeRequests' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-MergeRequests-Tests' with: [ spec requires: #('GitlabAPI-MergeRequests' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Notes' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Notes-Tests' with: [ spec requires: #('GitlabAPI-Notes' 'Mocketry') ]
	

]
