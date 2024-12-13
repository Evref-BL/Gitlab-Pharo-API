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
