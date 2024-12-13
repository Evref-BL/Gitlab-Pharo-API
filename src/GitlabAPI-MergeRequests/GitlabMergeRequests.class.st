Class {
	#name : 'GitlabMergeRequests',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-MergeRequests',
	#package : 'GitlabAPI-MergeRequests'
}

{ #category : 'as yet unclassified' }
GitlabMergeRequests >> diffsOf: mergeRequestIID inProject: projectId [
	"https://docs.gitlab.com/ee/api/merge_requests.html#list-merge-request-diffs"
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/diffs'.
	
	^self get: endpoint withParams: Dictionary new.
]

{ #category : 'api' }
GitlabMergeRequests >> get: mergeRequestIID inProject: projectId [
	"https://docs.gitlab.com/ee/api/merge_requests.html#get-single-mr"
		
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString.
	
	^self get: endpoint withParams: Dictionary new.
]
