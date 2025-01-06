Class {
	#name : 'GitlabJobs',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Jobs',
	#package : 'GitlabAPI-Jobs'
}

{ #category : 'api' }
GitlabJobs >> allForPipeline: pipelineId inProject: projectId [ 
	"https://docs.gitlab.com/ee/api/jobs.html#list-pipeline-jobs"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/pipelines/', pipelineId asString, '/jobs'.
	
	^self getAll: endpoint withParams: Dictionary new
]
