"
A GitlabMergeRequestsTest is a test class for testing the behavior of GitlabMergeRequests
"
Class {
	#name : 'GitlabMergeRequestsTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-MergeRequests-Tests',
	#package : 'GitlabAPI-MergeRequests-Tests'
}

{ #category : 'tests' }
GitlabMergeRequestsTest >> testGetInProject [

	| hostUrl gitlabApi projectId result client gitlabMergeRequests mergeRequestIID path mergeRequest |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabMergeRequests := GitlabMergeRequests new gitlabAPI: gitlabApi.
	
	mergeRequestIID := 24.
	projectId := 1.
	
	mergeRequest := { 
		#id -> mergeRequestIID 
	} asDictionary.
	
	path := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString.
	(gitlabMergeRequests stub get: path withParams: Dictionary new) willReturn: mergeRequest.
	
	"When"
	result := gitlabMergeRequests get: mergeRequestIID inProject: projectId.
	
	"Then"
	self assert: (result at: #id) equals: mergeRequestIID.
]
