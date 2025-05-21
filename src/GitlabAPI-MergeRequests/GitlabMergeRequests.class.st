Class {
	#name : 'GitlabMergeRequests',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-MergeRequests',
	#package : 'GitlabAPI-MergeRequests'
}

{ #category : 'api' }
GitlabMergeRequests >> allOfProject: projectId [
	"https://docs.gitlab.com/ee/api/merge_requests.html#list-project-merge-requests"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests'.
	
	^self allOfProject: projectId withParams: Dictionary new.
]

{ #category : 'api' }
GitlabMergeRequests >> allOfProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/merge_requests.html#list-project-merge-requests"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests'.
	
	^self getAll: endpoint withParams: paramsDict.
]

{ #category : 'api - approvals' }
GitlabMergeRequests >> approvalsOf: mergeRequestIID inProject: projectId [
	"https://docs.gitlab.com/ee/api/merge_request_approvals.html#merge-request-level-mr-approvals"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/approvals'.
	
	^self get: endpoint withParams: Dictionary new.
]

{ #category : 'api' }
GitlabMergeRequests >> commitsOf: mergeRequestIID inProject: projectId [
	"https://docs.gitlab.com/ee/api/merge_requests.html#get-single-merge-request-commits"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/commits'.
	
	^self getAll: endpoint withParams: Dictionary new. 
]

{ #category : 'api' }
GitlabMergeRequests >> createForProject: projectId withSourceBranch: sourceBranch targetBranch: targetBranch title: title [
	"https://docs.gitlab.com/ee/api/merge_requests.html#create-mr"
	
	| endpoint data |
	endpoint := '/projects/', projectId asString, '/merge_requests'.
	
	data := { 
		#source_branch -> sourceBranch.
		#target_branch -> targetBranch.
		#title -> title.
	} asDictionary.
	
	^self post: endpoint withData: data. 
]

{ #category : 'api' }
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

{ #category : 'api' }
GitlabMergeRequests >> getByPage: page perPage: perPage inProject: projectId [
	
	|endpoint|
	
	endpoint := '/projects/', projectId asString, '/merge_requests'.
	

	^ self getByPage: page perPage: perPage from: endpoint withParams: Dictionary new . 
]
