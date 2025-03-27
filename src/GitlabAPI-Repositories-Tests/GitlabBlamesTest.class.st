"
A GitlabBlamesTest is a test class for testing the behavior of GitlabBlames
"
Class {
	#name : 'GitlabBlamesTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Repositories-Tests',
	#package : 'GitlabAPI-Repositories-Tests'
}

{ #category : 'tests' }
GitlabBlamesTest >> testGetBlameFileOfProjectWithParams [

| hostUrl gitlabApi projectId result client gitlabBlames filePath response params |
	
	"Given"
	hostUrl := 'www.url.com'.
	client  := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabBlames := GitlabBlames new gitlabAPI: gitlabApi.
	
	filePath := 'file.txt'.
	projectId := 1.
	params := { 
		#ref -> 'ref'
	} asDictionary.
	
	response := '[{"line":"some code","commit":{"id":"123456"}}]' .

	(client stub get) willReturn: response.
	
	"When"
	 result := gitlabBlames  getBlameFile: filePath ofProject:projectId  withParams:params .
	
	"Then"
	self assert: result equals: (NeoJSONReader fromString: response).

]
