Class {
	#name : 'GitlabMergeRequests',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-MergeRequests',
	#package : 'GitlabAPI-MergeRequests'
}

{ #category : 'api' }
GitlabMergeRequests >> get: mergeRequestIID inProject: projectId [
	"https://docs.gitlab.com/ee/api/merge_requests.html#get-single-mr"
		
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString.
	
	^self get: endpoint withParams: Dictionary new.
]
