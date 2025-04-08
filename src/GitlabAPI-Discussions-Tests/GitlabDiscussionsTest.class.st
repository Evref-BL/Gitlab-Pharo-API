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

	| hostUrl client gitlabApi projectId mergeRequestIID discussionId objectId object gitlabDiscussions endpoint result objectId2 object2 object3|
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.
	projectId := 1.
	mergeRequestIID := 42.
	discussionId := 'abc123'.

	objectId := 'def456'.
	object := { (#id -> objectId) } asDictionary.

	objectId2 := 'abc123'.
	object2 := { (#id -> objectId2) } asDictionary.

	object3 := { object. object2 }.

	gitlabDiscussions := GitlabDiscussions new gitlabAPI: gitlabApi.
	endpoint := '/projects/' , projectId asString , '/merge_requests/' , mergeRequestIID asString , '/discussions'.

	(gitlabDiscussions stub get: endpoint withParams: Dictionary new) willReturn: object3.

	result := gitlabDiscussions getAllInMR: mergeRequestIID inProject: projectId.

	self assert: (result first at: #id) equals: objectId.
	self assert: result size equals: 2.

]

{ #category : 'tests' }
GitlabDiscussionsTest >> testGetInMergeRequestOfProject [
	"Given"

	| hostUrl client gitlabApi projectId mergeRequestIID discussionId objectId object gitlabDiscussions endpoint result |
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	projectId := 1.
	mergeRequestIID := 42.
	discussionId := 'abc123'.

	objectId := 'def456'.
	object := { (#id -> objectId) } asDictionary.

	gitlabDiscussions := GitlabDiscussions new gitlabAPI: gitlabApi.

	endpoint := '/projects/' , projectId asString , '/merge_requests/'
	            , mergeRequestIID asString , '/discussions/'
	            , discussionId.
	
	(gitlabDiscussions stub get: endpoint withParams: Dictionary new)
		willReturn: object.

	result := gitlabDiscussions
		          get: discussionId
		          inMergeRequest: mergeRequestIID
		          ofProject: projectId.

	self assert: (result at: #id) equals: objectId

]
