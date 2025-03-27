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
GitlabBlamesTest >> testGetBlameOfInRefOfProject [

| hostUrl gitlabApi projectId result client gitlabBlames filePath response   ref |
	
	"Given"
	hostUrl := 'www.url.com'.
	client  := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabBlames := GitlabBlames new gitlabAPI: gitlabApi.
	
	filePath := 'file.txt'.
	projectId := 1.
   ref := 'branch'.
	
	response := '[{"line":" code","commit":{"id":"123456"}}]' .

	(client stub get) willReturn: response.
	
	"When"
     result := gitlabBlames 	getBlameOf: filePath inRef: ref ofProject: projectId.
	
	"Then"
	self assert: result equals: (NeoJSONReader fromString: response).

]

{ #category : 'tests' }
GitlabBlamesTest >> testGetBlameOfInRefWithRangeOfProject [


| hostUrl gitlabApi projectId result client gitlabBlames filePath response  ref range |
	
	"Given"
	hostUrl := 'www.url.com'.
	client  := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabBlames := GitlabBlames new gitlabAPI: gitlabApi.
	
	filePath := 'file.txt'.
	ref:= 'branch'.
	range := 'range '.
	projectId := 1.

	response := '[{"line":" code","commit":{"id":"123456"}}]' .

	(client stub get) willReturn: response.
	
	"When"
	 result := gitlabBlames  getBlameOf: filePath inRef: ref withRange: range ofProject:projectId .
	
	"Then"
	self assert: result equals: (NeoJSONReader fromString: response).

]
