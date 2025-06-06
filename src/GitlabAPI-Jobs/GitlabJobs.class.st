Class {
	#name : 'GitlabJobs',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Jobs',
	#package : 'GitlabAPI-Jobs'
}

{ #category : 'api' }
GitlabJobs >> allForPipeline: pipelineId inProject: projectId [ 
	"https://docs.gitlab.com/ee/api/jobs.html#list-pipeline-jobs"
	
	
	self deprecated: 'Use jobsOfPipeline:inProject: instead' transformWith: 
				'`@rcv allForPipeline: `@arg1 inProject: `@arg2' 
				-> '`@rcv getAllForPipeline: `@arg1 inProject: `@arg2' .
	
	^ self getAllForPipeline: pipelineId inProject: projectId. 
]

{ #category : 'api' }
GitlabJobs >> getAllForPipeline: pipelineId inProject: projectId [
	"https://docs.gitlab.com/ee/api/jobs.html#list-pipeline-jobs"
	
	^ self getAllForPipeline: pipelineId inProject: projectId includingRetried: nil withScope: nil.
]

{ #category : 'api' }
GitlabJobs >> getAllForPipeline: pipelineId inProject: projectId includingRetried: include_retried withScope: scope [
	"https://docs.gitlab.com/ee/api/jobs.html#list-pipeline-jobs"
	
	| endpoint params|
	

	endpoint := '/projects/', projectId asString, '/pipelines/', pipelineId asString, '/jobs'.
	params := Dictionary new. 
	include_retried ifNotNil: [  params at: #include_retried  put: include_retried]. 
	scope ifNotNil: [  params at: #scope  put: scope]. 

	
	^self getAll: endpoint withParams: params
]
