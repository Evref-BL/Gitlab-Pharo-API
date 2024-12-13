"
A GitlabRepositoriesTest is a test class for testing the behavior of GitlabRepositories
"
Class {
	#name : 'GitlabRepositoriesTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Repositories-Tests',
	#package : 'GitlabAPI-Repositories-Tests'
}

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProject [

	| hostUrl gitlabApi projectId result client path gitlabRepositories filePath response |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabRepositories := GitlabRepositories new gitlabAPI: gitlabApi.
	
	filePath := 'file.txt'.
	projectId := 1.
	
	response := 'content'.
	
	path := '/projects/', projectId asString, '/repository/files/', filePath encodeFilePath, '/raw'.
	(client stub get: hostUrl, path) willReturn: response.
	
	"When"
	result := gitlabRepositories getRawFile: filePath ofProject: projectId.
	
	"Then"
	self assert: result equals: response.
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectWithParams [

	| hostUrl gitlabApi projectId result client gitlabRepositories filePath response params |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabRepositories := GitlabRepositories new gitlabAPI: gitlabApi.
	
	filePath := 'file.txt'.
	projectId := 1.
	params := { 
		#ref -> 'ref'
	} asDictionary.
	
	response := 'content'.
	
	(client stub get) willReturn: response.
	
	"When"
	result := gitlabRepositories getRawFile: filePath ofProject: projectId withParams: params.
	
	"Then"
	self assert: result equals: response.
	params keysAndValuesDo: [ :key :value | self assert: (client request url query at: key) equals: value ].
	
]
