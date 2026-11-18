"
A GitlabRepositoriesTest is a test class for testing the behavior of GitlabRepositories
"
Class {
	#name : 'GitlabRepositoriesTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Repositories-Tests',
	#package : 'GitlabAPI-Repositories-Tests'
}

{ #category : 'accessing' }
GitlabRepositoriesTest >> accentedText [
	"A text with a character that UTF-8 and Latin-1 encode differently"

	^ String
		  with: $h
		  with: (Character value: 233)
		  with: $l
		  with: $l
		  with: $o
]

{ #category : 'accessing' }
GitlabRepositoriesTest >> accentedTextInLatin1 [
	"The bytes of the accented text in Latin-1, where they are not valid UTF-8"

	^ ZnCharacterEncoder latin1 encodeString: self accentedText
]

{ #category : 'running' }
GitlabRepositoriesTest >> serve: anEntity during: aBlock [
	"Evaluate aBlock with a GitlabApi whose host is a local server answering anEntity to every request"

	| server |
	server := ZnServer on: 0.
	[
		server
			start;
			onRequestRespond: [ :request | ZnResponse ok: anEntity ].
		aBlock value: (GitlabApi new
				 privateToken: 'token';
				 hostUrl: 'http://localhost:' , server port printString;
				 yourself) ] ensure: [ server stop ]
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testCompareInProjectFromTo [

	| hostUrl gitlabApi projectId result client path gitlabRepositories from to params response |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.
	gitlabRepositories := GitlabRepositories new gitlabAPI: gitlabApi.

	projectId := 1.
	from := 'azfo334'.
	to := 'fjfdiez3450'.

	params := {
		          (#from -> from).
		          (#to -> to) } asDictionary.

	response := { (#diffs -> 'diffs') } asDictionary.

	path := '/projects/' , projectId asString , '/repository/compare'.
	(gitlabRepositories stub get: path withParams: params) willReturn:
		response.

	"When"
	result := gitlabRepositories
		          compareInProject: projectId
		          from: from
		          to: to.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetBlameOfInRefOfProject [

	| hostUrl gitlabApi projectId result client gitlabRepositories filePath response ref path params |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client;
		             yourself.
	gitlabRepositories := GitlabRepositories new
		                      gitlabAPI: gitlabApi;
		                      yourself.
	ref := 'branch'.
	params := { (#ref -> ref) } asDictionary.
	filePath := 'file.txt'.
	projectId := 1.

	response := {
		            (#line -> 'a line of code').
		            (#commit -> { (#id -> '15616510') } asDictionary) }
		            asDictionary.
	path := '/projects/' , projectId asString , '/repository/files/'
	        , filePath encodeFilePath , '/blame'.

	(gitlabRepositories stub get: path withParams: params) willReturn:
		response.


	"When"
	result := gitlabRepositories
		          getBlameOf: filePath
		          inRef: ref
		          ofProject: projectId.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetBlameOfInRefStartEndOfProject [

	| hostUrl gitlabApi projectId result client gitlabRepositories filePath response ref path params |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.
	gitlabRepositories := GitlabRepositories new gitlabAPI: gitlabApi.
	ref := 'branch'.

	params := {
		          (#ref -> ref).
		          (#start -> 1).
		          (#end -> 5) } asDictionary.
	filePath := 'file.txt'.
	ref := 'branch'.

	projectId := 1.
	path := '/projects/' , projectId asString , '/repository/files/'
	        , filePath encodeFilePath , '/blame'.
	response := '[{"line":" some lines of code for this file ","commit":{"id":"123456"}}]'.

	(gitlabRepositories stub get: path withParams: params) willReturn:
		response.

	"When"
	result := gitlabRepositories
		          getBlameOf: filePath
		          inRef: ref
		          start: 1
		          end: 5
		          ofProject: projectId.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileBytesOfProject [

	| bytes result |
	bytes := self accentedText utf8Encoded.

	self
		serve: (ZnEntity with: bytes type: 'text/plain; charset=utf-8')
		during: [ :gitlabApi |
				result := gitlabApi repositories
					          getRawFileBytes: 'file.txt'
					          ofProject: 1 ].

	self assert: result equals: bytes
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProject [

	| hostUrl gitlabApi projectId result client path gitlabRepositories filePath response |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.
	gitlabRepositories := GitlabRepositories new gitlabAPI: gitlabApi.

	filePath := 'file.txt'.
	projectId := 1.

	response := 'content'.

	path := '/projects/' , projectId asString , '/repository/files/'
	        , filePath encodeFilePath , '/raw'.
	(client stub get: hostUrl , path) willReturn: response.

	"When"
	result := gitlabRepositories
		          getRawFile: filePath
		          ofProject: projectId.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectAnswersBytesOfBinaryFile [

	| bytes result |
	bytes := #[ 137 80 78 71 0 255 ].

	self
		serve: (ZnEntity with: bytes type: 'application/octet-stream')
		during: [ :gitlabApi |
			result := gitlabApi repositories
				          getRawFile: 'image.png'
				          ofProject: 1 ].

	self assert: result equals: bytes
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectDecodesInvalidBytesWithLatin1 [

	| result |
	self
		serve: (ZnEntity
				 with: self accentedTextInLatin1
				 type: 'text/plain; charset=utf-8')
		during: [ :gitlabApi |
			result := gitlabApi repositories
				          getRawFile: 'file.txt'
				          ofProject: 1 ].

	self assert: result equals: self accentedText
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectDecodesTextWithItsCharset [

	| result |
	self
		serve: (ZnEntity
				 with: self accentedText utf8Encoded
				 type: 'text/plain; charset=utf-8')
		during: [ :gitlabApi |
			result := gitlabApi repositories
				          getRawFile: 'file.txt'
				          ofProject: 1 ].

	self assert: result equals: self accentedText
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectRestoresTheReadersOfTheClient [

	| reader contentReader |
	self
		serve: (ZnEntity
				 with: self accentedTextInLatin1
				 type: 'text/plain; charset=utf-8')
		during: [ :gitlabApi |
				reader := gitlabApi client reader.
				contentReader := gitlabApi client contentReader.

				gitlabApi repositories getRawFile: 'file.txt' ofProject: 1.

				self assert: gitlabApi client reader identicalTo: reader.
				self
					assert: gitlabApi client contentReader
					identicalTo: contentReader ]
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectWithParams [

	| hostUrl gitlabApi projectId result client gitlabRepositories filePath response params |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.
	gitlabRepositories := GitlabRepositories new gitlabAPI: gitlabApi.

	filePath := 'file.txt'.
	projectId := 1.
	params := { (#ref -> 'ref') } asDictionary.

	response := 'content'.

	client stub get willReturn: response.

	"When"
	result := gitlabRepositories
		          getRawFile: filePath
		          ofProject: projectId
		          withParams: params.

	"Then"
	self assert: result equals: response.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectWithParamsDecodesInvalidBytesWithLatin1 [

	| result |
	self
		serve: (ZnEntity
				 with: self accentedTextInLatin1
				 type: 'text/plain; charset=utf-8')
		during: [ :gitlabApi |
				result := gitlabApi repositories
					          getRawFile: 'file.txt'
					          ofProject: 1
					          withParams: { (#ref -> 'main') } asDictionary ].

	self assert: result equals: self accentedText
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testGetRawFileOfProjectWithParamsEncoding [

	| result |
	self
		serve: (ZnEntity
				 with: self accentedTextInLatin1
				 type: 'text/plain; charset=utf-8')
		during: [ :gitlabApi |
				result := gitlabApi repositories
					          getRawFile: 'file.txt'
					          ofProject: 1
					          withParams: Dictionary new
					          encoding: 'latin1' ].

	self assert: result equals: self accentedText
]

{ #category : 'tests' }
GitlabRepositoriesTest >> testRepositoryTreeOfProjectWithParams [

	| hostUrl gitlabApi result client objectId object endpoint params projectId gitlabRepositories |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	gitlabApi := GitlabApi new
		             privateToken: 'token';
		             hostUrl: hostUrl;
		             client: client.

	projectId := 4.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.

	gitlabRepositories := GitlabRepositories new gitlabAPI: gitlabApi.

	endpoint := '/projects/' , projectId asString , '/repository/tree'.
	(gitlabRepositories stub getAll: endpoint withParams: params)
		willReturn: { object }.

	"When"
	result := gitlabRepositories
		          repositoryTreeOfProject: projectId
		          withParams: params.

	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId
]
