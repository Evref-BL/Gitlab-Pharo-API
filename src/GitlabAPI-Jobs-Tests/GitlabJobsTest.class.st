"
A GitlabJobsTest is a test class for testing the behavior of GitlabJobs
"
Class {
	#name : 'GitlabJobsTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Jobs-Tests',
	#package : 'GitlabAPI-Jobs-Tests'
}

{ #category : 'tests' }
GitlabJobsTest >> testAllForPipelineInProject [
	
	"Given"
	| hostUrl client gitlabApi projectId pipelineId objectId object gitlabJobs endpoint result |
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	pipelineId := 2346.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabJobs := GitlabJobs new gitlabAPI: gitlabApi.
	
	
	endpoint := '/projects/', projectId asString, '/pipelines/', pipelineId asString, '/jobs'. 	
	(gitlabJobs stub getAll: endpoint withParams: Dictionary new) willReturn: { object }.
	
	"When"
	result := gitlabJobs jobsOfPipeline: pipelineId inProject: projectId.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]
