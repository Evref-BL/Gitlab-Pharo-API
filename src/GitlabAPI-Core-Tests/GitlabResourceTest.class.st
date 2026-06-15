"
A GitlabRessourceTest is a test class for testing the behavior of GitlabRessource
"
Class {
	#name : 'GitlabResourceTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Core-Tests',
	#package : 'GitlabAPI-Core-Tests'
}

{ #category : 'tests' }
GitlabResourceTest >> testGetAllWithParams [

	| hostUrl gitlabApi result client objectId object endpoint gitlabResource params |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	(gitlabResource stub
		 getByPage: 1
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: { object }.
	(gitlabResource stub
		 getByPage: 2
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: { object }.
	(gitlabResource stub
		 getByPage: 3
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: {  }.

	"When"
	result := gitlabResource getAll: endpoint withParams: params.

	"Then"
	self assert: result size equals: 2.
	self assert: (result first at: #id) equals: objectId
]

{ #category : 'tests' }
GitlabResourceTest >> testGetAllWithParamsIfError [

	| hostUrl gitlabApi result client objectId object endpoint gitlabResource params error |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	error := { (#message
	          -> '403 Forbidden - Not authorized to access /api/v4/users') }
		         asDictionary.

	(gitlabResource stub
		 getByPage: 1
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: error.

	"When"
	result := gitlabResource getAll: endpoint withParams: params.

	"Then"
	self assert: result equals: error
]

{ #category : 'tests' }
GitlabResourceTest >> testGetAllWithParamsJSONOutput [

	| hostUrl gitlabApi result client objectId object endpoint gitlabResource params jsonObject |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client;
		             output: 'json'.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.
	jsonObject := NeoJSONWriter toString: { object }.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	(gitlabResource stub
		 getByPage: 1
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: jsonObject.
	(gitlabResource stub
		 getByPage: 2
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: jsonObject.
	(gitlabResource stub
		 getByPage: 3
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: '[]'.

	"When"
	result := gitlabResource getAll: endpoint withParams: params.

	"Then"
	self assert: result size equals: 2.
	self assert: result first equals: jsonObject
]

{ #category : 'tests' }
GitlabResourceTest >> testGetAllWithParamsJSONOutputIfError [

	| hostUrl gitlabApi result client objectId object endpoint gitlabResource params error |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client;
		             output: 'json'.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	error := '{"message":"403 Forbidden - Not authorized to access /api/v4/users"}'.

	(gitlabResource stub
		 getByPage: 1
		 perPage: 20
		 from: endpoint
		 withParams: params) willReturn: error.

	"When"
	result := gitlabResource getAll: endpoint withParams: params.

	"Then"
	self assert: result equals: error
]

{ #category : 'tests' }
GitlabResourceTest >> testGetByPagePerPageFromWithParams [

	| hostUrl gitlabApi result client objectId object page perPage endpoint params |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	page := 1.
	perPage := 10.
	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := '{ "id":' , objectId asString , ' }'.

	client stub get willReturn: '[ ' , object , ']'.

	"When"
	result := GitlabResource new
		          gitlabAPI: gitlabApi;
		          getByPage: page
		          perPage: perPage
		          from: endpoint
		          withParams: params.

	"Then"
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ].
	self
		assert: (client request url query at: #page)
		equals: page asString.
	self
		assert: (client request url query at: #per_page)
		equals: perPage asString.
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId
]

{ #category : 'tests' }
GitlabResourceTest >> testGetWithParams [

	| hostUrl gitlabApi result client object endpoint gitlabResource params |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	object := { (#id -> 1) } asDictionary.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	client stub get willReturn: (NeoJSONWriter toString: object).

	"When"
	result := gitlabResource get: endpoint withParams: params.

	"Then"
	self assert: result equals: object.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]

{ #category : 'tests' }
GitlabResourceTest >> testGetWithParamsJSONOutput [

	| hostUrl gitlabApi result client object endpoint gitlabResource params |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client;
		             output: 'json'.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	object := { (#id -> 1) } asDictionary.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	client stub get willReturn: (NeoJSONWriter toString: object).

	"When"
	result := gitlabResource get: endpoint withParams: params.

	"Then"
	self assert: result equals: (NeoJSONWriter toString: object).
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]

{ #category : 'tests' }
GitlabResourceTest >> testPostJsonWithData [

	| hostUrl gitlabApi result client endpoint gitlabResource data responseMessage response |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := '{ "message": "' , responseMessage , '" }'.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	client stub post willReturn: response.

	"When"
	result := gitlabResource postJson: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	self
		assert: client request entity contentType asString
		equals: 'application/json'.
	self
		assert: client request entity string
		equals: (NeoJSONWriter toString: data)
]

{ #category : 'tests' }
GitlabResourceTest >> testPostWithData [

	| hostUrl gitlabApi result client endpoint gitlabResource data responseMessage response |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := '{ "message": "' , responseMessage , '" }'.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	client stub post willReturn: response.

	"When"
	result := gitlabResource post: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	data keysAndValuesDo: [ :key :value |
		self
			assert: (client request url query at: key)
			equals: (data at: key) ]
]

{ #category : 'tests' }
GitlabResourceTest >> testPostWithFormData [

	| hostUrl gitlabApi result client endpoint gitlabResource data responseMessage response |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := '{ "message": "' , responseMessage , '" }'.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	client stub post willReturn: response.

	"When"
	result := gitlabResource post: endpoint withFormData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	data keysAndValuesDo: [ :key :value |
		self
			assert: (client request entity fields at: key)
			equals: (data at: key) ]
]
