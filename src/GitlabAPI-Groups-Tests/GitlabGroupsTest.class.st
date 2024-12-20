"
A GitlabGroupsTest is a test class for testing the behavior of GitlabGroups
"
Class {
	#name : 'GitlabGroupsTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Groups-Tests',
	#package : 'GitlabAPI-Groups-Tests'
}

{ #category : 'tests' }
GitlabGroupsTest >> testGet [

	| hostUrl gitlabApi result client path gitlabGroups groupId group |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabGroups := GitlabGroups new gitlabAPI: gitlabApi.
	
	groupId := 5.  
	
	group := { 
		#id -> groupId 
	} asDictionary.
	
	path := '/groups/', groupId asString.
	(gitlabGroups stub get: path withParams: Dictionary new) willReturn: group.
	
	"When"
	result := gitlabGroups get: groupId.
	
	"Then"
	self assert: (result at: #id) equals: groupId.
]

{ #category : 'tests' }
GitlabGroupsTest >> testGetAll [
	| hostUrl gitlabApi result client object endpoint objects gitlabGroups |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	object := { #id -> 4 } asDictionary.
	objects := { object }.
	
	gitlabGroups := GitlabGroups new gitlabAPI: gitlabApi.
	
	endpoint := '/groups'.
	(gitlabGroups stub getAllWithParams: Dictionary new) willReturn: objects.
	
	"When"
	result := gitlabGroups getAll.
	
	"Then"
	self assert: result size equals: objects size.
	self assert: result first equals: object.
]

{ #category : 'tests' }
GitlabGroupsTest >> testGetAllWithParams [

	| hostUrl gitlabApi result client object endpoint params objects gitlabGroups |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	params := { 'param' -> 'value' } asDictionary.
	
	object := { #id -> 4 } asDictionary.
	objects := { object }.
	
	gitlabGroups := GitlabGroups new gitlabAPI: gitlabApi.
	
	endpoint := '/groups'.
	(gitlabGroups stub getAll: endpoint withParams: params) willReturn: objects.
	
	"When"
	result := gitlabGroups getAllWithParams: params.
	
	"Then"
	self assert: result size equals: objects size.
	self assert: result first equals: object.
]

{ #category : 'tests' }
GitlabGroupsTest >> testGetByPagePerPageWithParams [
	
	| hostUrl gitlabApi result client object endpoint params page perPage objects gitlabGroups |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	page := 1.
	perPage := 3.
	params := { 'param' -> 'value' } asDictionary.
	
	object := { #id -> 4 } asDictionary.
	objects := { object }.
	
	gitlabGroups := GitlabGroups new gitlabAPI: gitlabApi.
	
	endpoint := '/groups'.
	(gitlabGroups stub getByPage: page perPage: perPage from: endpoint withParams: params) willReturn: objects.
	
	"When"
	result := gitlabGroups getByPage: page perPage: perPage withParams: params. 
	
	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: object.
]

{ #category : 'tests' }
GitlabGroupsTest >> testSubgroupsOf [

	| hostUrl gitlabApi result client object objects gitlabGroups groupId |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	object := { #id -> 4 } asDictionary.
	objects := { object }.
	
	groupId := 4.
	gitlabGroups := GitlabGroups new gitlabAPI: gitlabApi.
	
	(gitlabGroups stub subgroupsOf: groupId withParams: Dictionary new) willReturn: objects.
	
	"When"
	result := gitlabGroups subgroupsOf: groupId.
	
	"Then"
	self assert: result size equals: objects size.
	self assert: result first equals: object.
]

{ #category : 'tests' }
GitlabGroupsTest >> testSubgroupsOfWithParams [

	| hostUrl gitlabApi result client object endpoint params objects gitlabGroups groupId |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	params := { 'param' -> 'value' } asDictionary.
	
	object := { #id -> 4 } asDictionary.
	objects := { object }.
	
	groupId := 4.
	gitlabGroups := GitlabGroups new gitlabAPI: gitlabApi.
	
	endpoint := '/groups/', groupId asString, '/subgroups'.
	(gitlabGroups stub getAll: endpoint withParams: params) willReturn: objects.
	
	"When"
	result := gitlabGroups subgroupsOf: groupId withParams: params.
	
	"Then"
	self assert: result size equals: objects size.
	self assert: result first equals: object.
]
