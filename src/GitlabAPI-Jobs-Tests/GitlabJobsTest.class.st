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

	| gitlabApi projectId pipelineId objectId object gitlabJobs endpoint result |
	"Given"
	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: 'https://www.url.com';
		             client: ZnClient new.

	projectId := 1.
	pipelineId := 2346.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.

	endpoint := '/projects/' , projectId asString , '/pipelines/'
	            , pipelineId asString , '/jobs'.

	gitlabJobs := GitlabJobs new gitlabAPI: gitlabApi.

	(gitlabJobs stub getAll: endpoint withParams: Dictionary new)
		willReturn: { object }.

	"When"
	result := gitlabJobs
		          getAllForPipeline: pipelineId
		          inProject: projectId.

	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId
]

{ #category : 'tests' }
GitlabJobsTest >> testGetByPagePerPageInProject [

	| gitlabApi projectId page perPage objects object result gitlabJobs |
	"Given"
	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: 'https://www.url.com';
		             client: ZnClient new.

	projectId := 1.
	page := 1.
	perPage := 3.

	object := { (#id -> 4) } asDictionary.
	objects := { object }.

	gitlabJobs := GitlabJobs new gitlabAPI: gitlabApi.

	(gitlabJobs stub
		 getByPage: page
		 perPage: perPage
		 inProject: projectId
		 withParams: Dictionary new) willReturn: objects.

	"When"
	result := gitlabJobs
		          getByPage: page
		          perPage: perPage
		          inProject: projectId.

	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: object
]

{ #category : 'tests' }
GitlabJobsTest >> testGetByPagePerPageInProjectWithParams [

	| gitlabApi projectId page perPage params objects object gitlabJobs result |
	"Given"
	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: 'https://www.url.com';
		             client: ZnClient new.

	projectId := 1.
	page := 1.
	perPage := 3.
	params := { ('param' -> 'value') } asDictionary.

	object := { (#id -> 4) } asDictionary.
	objects := { object }.

	gitlabJobs := GitlabJobs new gitlabAPI: gitlabApi.

	(gitlabJobs stub
		 getByPage: page
		 perPage: perPage
		 from: '/projects/' , projectId asString , '/jobs'
		 withParams: params) willReturn: objects.

	"When"
	result := gitlabJobs
		          getByPage: page
		          perPage: perPage
		          inProject: projectId
		          withParams: params.

	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: object
]
