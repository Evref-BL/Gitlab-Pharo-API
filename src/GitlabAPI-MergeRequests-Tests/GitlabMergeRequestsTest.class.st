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
GitlabMergeRequestsTest >> testCommitsOfInProject [

	| hostUrl gitlabApi result client objectId object endpoint projectId mergeRequestId gitlabMergeRequests |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	mergeRequestId := 24.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabMergeRequests := GitlabMergeRequests new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestId asString, '/commits'.
	(gitlabMergeRequests stub getAll: endpoint withParams: Dictionary new) willReturn: { object }.
	
	"When"
	result := gitlabMergeRequests commitsOf: mergeRequestId inProject: projectId.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabMergeRequestsTest >> testCreateForProjectWithSourceBranchTargetBranchTitle [

	"Given"
	| hostUrl client gitlabApi gitlabMergeRequests projectId sourceBranch targetBranch title message endpoint data response result |
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabMergeRequests := GitlabMergeRequests new gitlabAPI: gitlabApi.
	
	projectId := 1.
	sourceBranch := 'test'.
	targetBranch := 'main'.
	title := 'title'.
	message := 'message'.
	
	endpoint := '/projects/', projectId asString, '/merge_requests'.
	
	data := { 
		#source_branch -> sourceBranch.
		#target_branch -> targetBranch.
		#title -> title	
	} asDictionary.
	
	
	response := { 
		#message -> message
	} asDictionary.
	
	(gitlabMergeRequests stub post: endpoint withData: data) willReturn: response.
	
	"When"
	result := gitlabMergeRequests createForProject: projectId withSourceBranch: sourceBranch targetBranch: targetBranch title: title.
	
	"Then"
	self assert: (result at: #message) equals: (response at: #message).
]

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
