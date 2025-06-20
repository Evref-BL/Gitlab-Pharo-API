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
	spec package: 'GitlabAPI-Core-Tests' with: [ spec requires: #('GitlabAPI-Core' 'Mocketry') ].
		
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
	spec package: 'GitlabAPI-Notes-Tests' with: [ spec requires: #('GitlabAPI-Notes' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Repositories' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Repositories-Tests' with: [ spec requires: #('GitlabAPI-Repositories' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Groups' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Groups-Tests' with: [ spec requires: #('GitlabAPI-Groups' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Pipelines' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Pipelines-Tests' with: [ spec requires: #('GitlabAPI-Pipelines' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Jobs' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Jobs-Tests' with: [ spec requires: #('GitlabAPI-Jobs' 'Mocketry')].
		
	spec package: 'GitlabAPI-Users' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Users-Tests' with: [ spec requires: #('GitlabAPI-Users' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Tag' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Tag-Tests' with: [ spec requires: #('GitlabAPI-Tag' 'Mocketry') ].
	
	spec package: 'GitlabAPI-Release' with: [ spec requires: #('GitlabAPI-Core') ].
	spec package: 'GitlabAPI-Release-Tests' with: [ spec requires: #('GitlabAPI-Release' 'Mocketry') ].
]
