"
A GitlabProjectsTest is a test class for testing the behavior of GitlabProjects
"
Class {
	#name : 'GitlabProjectsTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Projects-Tests',
	#package : 'GitlabAPI-Projects-Tests'
}

{ #category : 'tests' }
GitlabProjectsTest >> testAllWithParams [

	| hostUrl gitlabApi result client objectId object endpoint params gitlabProjects |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	params := { 'param' -> 'value' } asDictionary.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabProjects := GitlabProjects new gitlabAPI: gitlabApi.
	
	endpoint := '/projects'.
	(gitlabProjects stub getAll: endpoint withParams: params) willReturn: { object }.
	
	"When"
	result := gitlabProjects allWithParams: params.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabProjectsTest >> testGet [

	"Given"
	| project client gitlabApi result hostUrl projectId |
	hostUrl := 'www.url.com'.
	projectId := 1.
	
	project := '{ "name": "test", "id":', projectId asString, '}'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'privateToken'; hostUrl: hostUrl; client: client.
	
	(client stub get: hostUrl, '/projects/', projectId asString) willReturn: project.

	
	"When"
	result := gitlabApi projects get: projectId.
	
	"Then"
	self assert: (result at: #id) equals: projectId
	
]
