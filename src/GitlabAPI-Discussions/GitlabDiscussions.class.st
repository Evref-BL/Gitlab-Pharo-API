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

{ #category : 'api' }
GitlabDiscussions >> get: discussionId inMergeRequest: mergeRequestIID ofProject: projectId [
	"https://docs.gitlab.com/api/discussions/#get-single-merge-request-discussion-item"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/discussions/', discussionId.
	
	^self get: endpoint withParams: Dictionary new.
]

{ #category : 'api' }
GitlabDiscussions >> getAllInMR: mergeRequestIID inProject: projectId [
	"https://docs.gitlab.com/api/discussions/#list-project-merge-request-discussion-items"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/discussions'.
	
	^self get: endpoint withParams: Dictionary new.
]
