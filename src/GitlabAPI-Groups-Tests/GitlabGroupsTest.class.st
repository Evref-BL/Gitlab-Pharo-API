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
