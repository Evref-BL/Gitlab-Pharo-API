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
GitlabMergeRequestsTest >> testDiffsOfInProject [

	| hostUrl gitlabApi projectId result client gitlabMergeRequests mergeRequestIID path diff1 diff2 diffs |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabMergeRequests := GitlabMergeRequests new gitlabAPI: gitlabApi.
	
	mergeRequestIID := 24.
	projectId := 1.
	
	diff1 := { 
		#id -> 1.
		#file -> 'file1.txt' 
	} asDictionary.
	
	diff2 := { 
		#id -> 2.
		#file -> 'file2.txt' 
	} asDictionary.
	
	diffs := { 
		diff1 . diff2
	}.
	
	path := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/diffs'.
	(gitlabMergeRequests stub get: path withParams: Dictionary new) willReturn: diffs.
	
	"When"
	result := gitlabMergeRequests diffsOf: mergeRequestIID inProject: projectId.
	
	"Then"
	self assert: (result size) equals: 2.
	self assert: (result first) equals: diff1.
	self assert: (result last) equals: diff2.
]

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
