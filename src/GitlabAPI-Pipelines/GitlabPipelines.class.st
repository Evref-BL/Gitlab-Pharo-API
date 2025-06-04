Class {
	#name : 'GitlabPipelines',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Pipelines',
	#package : 'GitlabAPI-Pipelines'
}

{ #category : 'api' }
GitlabPipelines >> getAllInProject: projectId [
	"https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/pipelines'.

	^self getAll: endpoint withParams: Dictionary new.
]

{ #category : 'api' }
GitlabPipelines >> getByPage: page perPage: perPage inProject: projectId [
	"https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/pipelines'.
	
	^self getByPage: page perPage: perPage from: endpoint withParams: Dictionary new. 
]

{ #category : 'api' }
GitlabPipelines >> post: projectId withVariables: aVariableDictionary [
	"https://docs.gitlab.com/ci/triggers/#trigger-a-pipeline"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/trigger/pipeline'.

	^ self post: endpoint withFormData: aVariableDictionary
]
