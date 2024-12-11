"
A GitlabRessourceTest is a test class for testing the behavior of GitlabRessource
"
Class {
	#name : 'GitlabRessourceTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Core-Tests',
	#package : 'GitlabAPI-Core-Tests'
}

{ #category : 'tests' }
GitlabRessourceTest >> testGetAll [

	| hostUrl gitlabApi result client objectId object endpoint gitlabRessource |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	endpoint := '/endpoint'.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabRessource := GitlabRessource new gitlabAPI: gitlabApi.
	
	(gitlabRessource stub getByPage: 1 perPage: 20 from: endpoint) willReturn: { object }.
	(gitlabRessource stub getByPage: 2 perPage: 20 from: endpoint) willReturn:  { object }.
	(gitlabRessource stub getByPage: 3 perPage: 20 from: endpoint) willReturn: {}.
	
	"When"
	result := gitlabRessource getAll: endpoint.
	
	"Then"
	self assert: result size equals: 2.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabRessourceTest >> testGetByPagePerPageFrom [

	| hostUrl gitlabApi result client objectId object page perPage endpoint |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	page := 1.
	perPage := 10.
	endpoint := '/endpoint'.
	
	objectId := 1.
	object := '{ "id":', objectId asString ,' }'.
	
	(client stub get) willReturn: '[ ', object , ']'.
	
	"When"
	result := GitlabRessource new gitlabAPI: gitlabApi; getByPage: page perPage: perPage from: endpoint.
	
	"Then"
	self assert: (client request url query at: #page) equals: page asString.
	self assert: (client request url query at: #per_page) equals: perPage asString.
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]
