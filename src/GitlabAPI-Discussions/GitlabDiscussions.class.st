Class {
	#name : 'GitlabDiscussions',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Discussions',
	#package : 'GitlabAPI-Discussions'
}

{ #category : 'api' }
GitlabDiscussions >> createThreadInMergeRequest: mergeRequestIID ofProject: projectId body: body position: gitlabThreadPosition [
	"https://docs.gitlab.com/ee/api/discussions.html#create-new-merge-request-thread"

	| endpoint data |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/discussions'.
	
	data := { 
		#body -> body.
	} asDictionary.
	
	data addAll: gitlabThreadPosition asDictionary.
	
	^self post: endpoint withData: data.
]
