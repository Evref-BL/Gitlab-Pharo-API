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
GitlabProjectsTest >> testAll [

	| hostUrl gitlabApi result client objectId object endpoint gitlabProjects |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabProjects := GitlabProjects new gitlabAPI: gitlabApi.
	
	endpoint := '/projects'.
	(gitlabProjects stub allWithParams: Dictionary new) willReturn: { object }.
	
	"When"
	result := gitlabProjects all.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

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
GitlabProjectsTest >> testContributedProjectsOfUserWithParams [

	| hostUrl gitlabApi result client objectId object endpoint params gitlabProjects userId |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	params := { 'param' -> 'value' } asDictionary.
	userId := 4.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabProjects := GitlabProjects new gitlabAPI: gitlabApi.
	
	endpoint := '/users/', userId asString, '/contributed_projects'.
	(gitlabProjects stub getAll: endpoint withParams: params) willReturn: { object }.
	
	"When"
	result := gitlabProjects contributedProjectsOfUser: userId withParams: params.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabProjectsTest >> testGet [

	| hostUrl gitlabApi result client objectId object endpoint gitlabProjects projectId |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 4.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabProjects := GitlabProjects new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString.
	(gitlabProjects stub get: endpoint withParams: Dictionary new) willReturn: { object }.
	
	"When"
	result := gitlabProjects get: projectId.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
	
]
