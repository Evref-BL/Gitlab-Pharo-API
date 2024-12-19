"
A GitlabPipelinesTest is a test class for testing the behavior of GitlabPipelines
"
Class {
	#name : 'GitlabPipelinesTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Pipelines-Tests',
	#package : 'GitlabAPI-Pipelines-Tests'
}

{ #category : 'tests' }
GitlabPipelinesTest >> testGetAllInProject [


	| hostUrl gitlabApi result client endpoint projectId pipeline pipelines gitlabPipelines |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	
	pipeline := { #id -> 4 } asDictionary.
	pipelines := { pipeline }.
	
	gitlabPipelines := GitlabPipelines new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString, '/pipelines'.
	(gitlabPipelines stub getAll: endpoint withParams: Dictionary new) willReturn: pipelines.
	
	"When"
	result := gitlabPipelines getAllInProject: projectId.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first) equals: pipeline.
]

{ #category : 'tests' }
GitlabPipelinesTest >> testGetByPagePerPageInProject [

	| hostUrl gitlabApi result client endpoint projectId page perPage pipeline pipelines gitlabPipelines |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	page := 1.
	perPage := 3.
	
	pipeline := { #id -> 4 } asDictionary.
	pipelines := { pipeline }.
	
	gitlabPipelines := GitlabPipelines new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString, '/pipelines'.
	(gitlabPipelines stub getByPage: page perPage: perPage  from: endpoint withParams: Dictionary new) willReturn: pipelines.
	
	"When"
	result := gitlabPipelines getByPage: page perPage: perPage inProject: projectId. 
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first) equals: pipeline.
]
