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
