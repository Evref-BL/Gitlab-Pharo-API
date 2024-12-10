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
