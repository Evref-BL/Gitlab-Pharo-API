"
A GitlabDiscussionsTest is a test class for testing the behavior of GitlabDiscussions
"
Class {
	#name : 'GitlabDiscussionsTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Discussions-Tests',
	#package : 'GitlabAPI-Discussions-Tests'
}

{ #category : 'tests' }
GitlabDiscussionsTest >> testCreateThreadInMergeRequestOfProjectBodyPosition [
	| hostUrl gitlabApi result client endpoint projectId mergeRequestIID body position data gitlabDiscussions response |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	mergeRequestIID := 1.
	body := 'content'.
	position := GitlabThreadPosition createWithBaseSha: 'baseSha' startSha: 'startSha'  headSha: 'headSha'  filePath: 'file.txt'. 
	
	data := { 
		#body -> body.
	 } asDictionary.
	
	data addAll: position asDictionary.
	
	gitlabDiscussions := GitlabDiscussions new gitlabAPI: gitlabApi.
	
	response := { 
		#message -> 'message' 
	} asDictionary.
	
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/discussions'.
	(gitlabDiscussions stub post: endpoint withData: data) willReturn: response.
	
	"When"
	result := gitlabDiscussions createThreadInMergeRequest: mergeRequestIID ofProject: projectId body: body position: position. 
	
	"Then"
	self assert: (result at: #message) equals: (response at: #message).
]

{ #category : 'tests' }
GitlabDiscussionsTest >> testGetAllInMRInProject [

	| hostUrl client gitlabApi projectId mergeRequestIID objectId object gitlabDiscussions endpoint result |
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.

	projectId := 1.
	mergeRequestIID := 42.

	objectId := 'abc123'.
	object := { #id -> objectId } asDictionary.

	gitlabDiscussions := GitlabDiscussions new gitlabAPI: gitlabApi.

	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/discussions'.
	(gitlabDiscussions stub getAllinMR: mergeRequestIID inProject: projectId) willReturn: { object }.

	"When"
	result := gitlabDiscussions getAllinMR: mergeRequestIID inProject: projectId.

	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.

]
