Class {
	#name : 'GitlabMergeRequests',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-MergeRequests',
	#package : 'GitlabAPI-MergeRequests'
}

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
