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
GitlabRessourceTest >> testGetAllWithParams [
	| hostUrl gitlabApi result client objectId object endpoint gitlabRessource params |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	endpoint := '/endpoint'.
	params := { 'param' -> 'value' } asDictionary.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabRessource := GitlabRessource new gitlabAPI: gitlabApi.
	
	(gitlabRessource stub getByPage: 1 perPage: 20 from: endpoint withParams: params) willReturn: { object }.
	(gitlabRessource stub getByPage: 2 perPage: 20 from: endpoint withParams: params) willReturn:  { object }.
	(gitlabRessource stub getByPage: 3 perPage: 20 from: endpoint withParams: params) willReturn: {}.
	
	"When"
	result := gitlabRessource getAll: endpoint withParams: params.
	
	"Then"
	self assert: result size equals: 2.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabRessourceTest >> testGetByPagePerPageFromWithParams [

	| hostUrl gitlabApi result client objectId object page perPage endpoint params |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	page := 1.
	perPage := 10.
	endpoint := '/endpoint'.
	params := { 'param' -> 'value' } asDictionary.
	
	objectId := 1.
	object := '{ "id":', objectId asString ,' }'.
	
	(client stub get) willReturn: '[ ', object , ']'.
	
	"When"
	result := GitlabRessource new gitlabAPI: gitlabApi; getByPage: page perPage: perPage from: endpoint withParams: params.
	
	"Then"
	params keysAndValuesDo: [ :key :value | self assert: (client request url query at: key) equals: value ].
	self assert: (client request url query at: #page) equals: page asString.
	self assert: (client request url query at: #per_page) equals: perPage asString.
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabRessourceTest >> testPostJsonWithData [
	| hostUrl gitlabApi result client endpoint gitlabRessource data responseMessage response |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	endpoint := '/endpoint'.
	data := { 'param' -> 'value' } asDictionary.
	
	responseMessage := 'success'.
	response := '{ "message": "', responseMessage, '" }'.
	
	gitlabRessource := GitlabRessource new gitlabAPI: gitlabApi.
	
	(client stub post) willReturn: response.
	
	"When"
	result := gitlabRessource postJson: endpoint withData: data.
	
	"Then"
	self assert: (result at: #message) equals: responseMessage.
	self assert: (client request entity contentType) asString equals: 'application/json'.
	self assert: (client request entity string) equals: (NeoJSONWriter toString: data).
]

{ #category : 'tests' }
GitlabRessourceTest >> testPostWithData [
	| hostUrl gitlabApi result client endpoint gitlabRessource data responseMessage response |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	endpoint := '/endpoint'.
	data := { 'param' -> 'value' } asDictionary.
	
	responseMessage := 'success'.
	response := '{ "message": "', responseMessage, '" }'.
	
	gitlabRessource := GitlabRessource new gitlabAPI: gitlabApi.
	
	(client stub post) willReturn: response.
	
	"When"
	result := gitlabRessource post: endpoint withData: data.
	
	"Then"
	self assert: (result at: #message) equals: responseMessage.
	data keysAndValuesDo: [ :key :value | 
		self assert: (client request url query at: key) equals: (data at: key).
	].
]
