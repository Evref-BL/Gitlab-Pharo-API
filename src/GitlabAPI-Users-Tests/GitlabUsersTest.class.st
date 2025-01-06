"
A GitlabUsersTest is a test class for testing the behavior of GitlabUsers
"
Class {
	#name : 'GitlabUsersTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Users-Tests',
	#package : 'GitlabAPI-Users-Tests'
}

{ #category : 'tests' }
GitlabUsersTest >> testAllWithParams [

	| hostUrl gitlabApi result client objectId object endpoint params gitlabUsers |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	params := { 'param' -> 'value' } asDictionary.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabUsers := GitlabUsers new gitlabAPI: gitlabApi.
	
	endpoint := '/users'.
	(gitlabUsers stub getAll: endpoint withParams: params) willReturn: { object }.
	
	"When"
	result := gitlabUsers allWithParams: params.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabUsersTest >> testGet [

	| hostUrl gitlabApi result client objectId object endpoint userId gitlabUsers |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	userId := 4.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabUsers := GitlabUsers new gitlabAPI: gitlabApi.
	
	endpoint := '/users/', userId asString.
	(gitlabUsers stub get: endpoint withParams: Dictionary new) willReturn: { object }.
	
	"When"
	result := gitlabUsers get: userId.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]
