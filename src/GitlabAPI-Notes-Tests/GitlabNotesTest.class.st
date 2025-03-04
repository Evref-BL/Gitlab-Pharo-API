"
A GitlabNotesTest is a test class for testing the behavior of GitlabNotes
"
Class {
	#name : 'GitlabNotesTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Notes-Tests',
	#package : 'GitlabAPI-Notes-Tests'
}

{ #category : 'tests' }
GitlabNotesTest >> testAllInMergeRequestOfProject [

	"Given"
	| hostUrl client gitlabApi projectId endpoint response result gitlabNotes mergeRequestIID |
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabNotes := GitlabNotes new gitlabAPI: gitlabApi.
	
	projectId := 1.
	mergeRequestIID := 2.
	
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/notes'.
	
	
	response := { 
		#note -> 'noteId'
	} asDictionary.
	
	(gitlabNotes stub getAll: endpoint withParams: Dictionary new) willReturn: response.
	
	"When"
	result := gitlabNotes  allInMergeRequest: mergeRequestIID ofProject: projectId. 
	
	"Then"
	self assert: result equals: response.
]

{ #category : 'tests' }
GitlabNotesTest >> testAllInMergeRequestOfProjectWithParams [

	"Given"
	| hostUrl client gitlabApi projectId endpoint response result gitlabNotes mergeRequestIID params |
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabNotes := GitlabNotes new gitlabAPI: gitlabApi.
	
	projectId := 1.
	mergeRequestIID := 2.
	params := {
		#sort -> 'asc'
	} asDictionary.
	
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/notes'.
	
	
	response := { 
		#note -> 'noteId'
	} asDictionary.
	
	(gitlabNotes stub getAll: endpoint withParams: params) willReturn: response.
	
	"When"
	result := gitlabNotes  allInMergeRequest: mergeRequestIID ofProject: projectId withParams: params. 
	
	"Then"
	self assert: result equals: response.
]

{ #category : 'tests' }
GitlabNotesTest >> testCreateInMergeRequestOfProjectWithBody [

	"Given"
	| hostUrl client gitlabApi projectId message endpoint data response result gitlabNotes mergeRequestIID body |
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabNotes := GitlabNotes new gitlabAPI: gitlabApi.
	
	projectId := 1.
	mergeRequestIID := 2.
	body := 'body'.
	message := 'message'.
	
	endpoint := '/projects/', projectId asString, '/merge_requests/', mergeRequestIID asString, '/notes'.
	
	data := { 
		#body -> body.
	} asDictionary.
	
	
	response := { 
		#message -> message
	} asDictionary.
	
	(gitlabNotes stub post: endpoint withData: data) willReturn: response.
	
	"When"
	result := gitlabNotes  createInMergeRequest: mergeRequestIID ofProject: projectId withBody: body.
	
	"Then"
	self assert: (result at: #message) equals: (response at: #message).
]
