"
A GitlabRessourceTest is a test class for testing the behavior of GitlabRessource
"
Class {
	#name : 'GitlabResourceTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Core-Tests',
	#package : 'GitlabAPI-Core-Tests'
}

{ #category : 'running' }
GitlabResourceTest >> fileServing: bytes type: mimeType [
	"Answer what getFile:withParams: answers when GitLab sends bytes with mimeType"

	^ self
		  serve: (ZnEntity with: bytes type: mimeType)
		  during: [ :gitlabApi |
				  (GitlabResource new gitlabAPI: gitlabApi)
					  getFile: '/file'
					  withParams: Dictionary new ]
]

{ #category : 'running' }
GitlabResourceTest >> serve: anEntity during: aBlock [
	"Answer the value of aBlock with a GitlabApi whose host is a local server answering anEntity to every request"

	| server |
	server := ZnServer on: 0.
	^ [
		  server
			  start;
			  onRequestRespond: [ :request | ZnResponse ok: anEntity ].
		  aBlock value: (GitlabApi new
				   privateToken: 'token';
				   hostUrl: 'http://localhost:' , server port printString;
				   yourself) ] ensure: [ server stop ]
]

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
GitlabResourceTest >> testGetFileWithParamsAnswersBytesOfBinaryFile [

	self
		assert: (self
				 fileServing: #[ 137 80 78 71 0 255 ]
				 type: 'application/octet-stream')
		equals: #[ 137 80 78 71 0 255 ]
]

{ #category : 'tests' }
GitlabResourceTest >> testGetFileWithParamsDecodesInvalidUTF8WithLatin1 [
	"233 is an accented e in Latin-1, it is not valid UTF-8"

	self
		assert: (self
				 fileServing: #[ 104 233 108 108 111 ]
				 type: 'text/plain; charset=utf-8')
		equals: #[ 104 233 108 108 111 ] asString
]

{ #category : 'tests' }
GitlabResourceTest >> testGetFileWithParamsDecodesUTF8 [

	| text |
	text := String with: $h with: (Character value: 233).

	self
		assert:
		(self
			 fileServing: text utf8Encoded
			 type: 'text/plain; charset=utf-8')
		equals: text
]

{ #category : 'tests' }
GitlabResourceTest >> testGetFileWithParamsRestoresTheReadersOfTheClient [

	self
		serve: (ZnEntity with: #[ 104 233 ] type: 'text/plain')
		during: [ :gitlabApi |
				| reader contentReader |
				reader := gitlabApi client reader.
				contentReader := gitlabApi client contentReader.

				(GitlabResource new gitlabAPI: gitlabApi)
					getFile: '/file'
					withParams: Dictionary new.

				self assert: gitlabApi client reader identicalTo: reader.
				self
					assert: gitlabApi client contentReader
					identicalTo: contentReader ]
]

{ #category : 'tests' }
GitlabResourceTest >> testGetRawWithParams [

	| hostUrl gitlabApi result client object rawObject endpoint gitlabResource params |
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
	rawObject := NeoJSONWriter toString: object.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	client stub get willReturn: rawObject.

	"When"
	result := gitlabResource getRaw: endpoint withParams: params.

	"Then"
	self assert: result equals: rawObject.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
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

	| hostUrl gitlabApi result client endpoint gitlabResource data responseMessage response sentEntity |
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

	client stub post will: [
			sentEntity := client request entity.
			response ].

	"When"
	result := gitlabResource postJson: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	self
		assert: sentEntity contentType asString
		equals: 'application/json'.
	self assert: sentEntity string equals: (NeoJSONWriter toString: data).
	self deny: client request hasEntity
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
GitlabResourceTest >> testPostWithDataAfterPostJsonWithDataSendsNoEntity [

	| hostUrl gitlabApi client gitlabResource response sentEntity |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	response := '{ "message": "success" }'.

	gitlabResource := GitlabResource new gitlabAPI: gitlabApi.

	client stub post willReturn: response.
	gitlabResource
		postJson: '/notes'
		withData: { ('body' -> 'summary') } asDictionary.

	client stub post will: [
			sentEntity := client request entity.
			response ].

	"When"
	gitlabResource
		post: '/discussions'
		withData: { ('body' -> 'suggestion') } asDictionary.

	"Then"
	self assert: sentEntity isNil
]

{ #category : 'tests' }
GitlabResourceTest >> testPostWithFormData [

	| hostUrl gitlabApi result client endpoint gitlabResource data responseMessage response sentEntity |
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

	client stub post will: [
			sentEntity := client request entity.
			response ].

	"When"
	result := gitlabResource post: endpoint withFormData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	data keysAndValuesDo: [ :key :value |
		self assert: (sentEntity fields at: key) equals: (data at: key) ].
	self deny: client request hasEntity
]

{ #category : 'tests' }
GitlabResourceTest >> testPutJsonWithData [

	| hostUrl gitlabApi result client endpoint gitlabResource data responseMessage response sentEntity |
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

	client stub put will: [
			sentEntity := client request entity.
			response ].

	"When"
	result := gitlabResource putJson: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	self
		assert: sentEntity contentType asString
		equals: 'application/json'.
	self assert: sentEntity string equals: (NeoJSONWriter toString: data).
	self deny: client request hasEntity
]
