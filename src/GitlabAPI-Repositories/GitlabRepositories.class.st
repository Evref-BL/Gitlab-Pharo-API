Class {
	#name : 'GitlabRepositories',
	#superclass : 'GitlabResource',
	#category : 'GitlabAPI-Repositories',
	#package : 'GitlabAPI-Repositories'
}

{ #category : 'api' }
GitlabRepositories >> compareInProject: projectId from: fromSHA to: toSHA [
	"https://docs.gitlab.com/ee/api/repositories.html#compare-branches-tags-or-commits"

	| endpoint params |
	endpoint := '/projects/' , projectId asString , '/repository/compare'.

	params := {
		          (#from -> fromSHA).
		          (#to -> toSHA) } asDictionary.

	^ self get: endpoint withParams: params
]

{ #category : 'api' }
GitlabRepositories >> getBlameOf: filePath inRef: ref ofProject: projectId [

	| endpoint params |
	params := { (#ref -> ref) } asDictionary.
	endpoint := '/projects/' , projectId asString , '/repository/files/'
	            , filePath encodeFilePath , '/blame'.

	^ self get: endpoint withParams: params
]

{ #category : 'api' }
GitlabRepositories >> getBlameOf: filePath inRef: ref start: startRange end: endRange ofProject: projectId [

	| endpoint params |
	params := {
		          (#ref -> ref).
		          (#start -> startRange).
		          (#end -> endRange) } asDictionary.
	endpoint := '/projects/' , projectId asString , '/repository/files/'
	            , filePath encodeFilePath , '/blame'.

	^ self get: endpoint withParams: params
]

{ #category : 'api' }
GitlabRepositories >> getRawFile: filePath ofProject: projectId [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository
	Answer a String for a textual file and a ByteArray for a binary one, as Zinc does,
	but never fail on bytes that are not valid in the charset of the file, see #rawContentsOf:"

	^ self
		  withContentReader: [ :entity | self rawContentsOf: entity ]
		  do: [
				  gitlabAPI client get: gitlabAPI hostUrl
					  , (self rawFileEndpoint: filePath ofProject: projectId) ]
]

{ #category : 'api' }
GitlabRepositories >> getRawFile: filePath ofProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository
	Answer a String for a textual file and a ByteArray for a binary one, as Zinc does,
	but never fail on bytes that are not valid in the charset of the file, see #rawContentsOf:"

	^ self
		  withContentReader: [ :entity | self rawContentsOf: entity ]
		  do: [
				  self
					  getRaw: (self rawFileEndpoint: filePath ofProject: projectId)
					  withParams: paramsDict ]
]

{ #category : 'api' }
GitlabRepositories >> getRawFile: filePath ofProject: projectId withParams: paramsDict encoding: encodingName [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository
	Answer the file decoded with the encoding named encodingName, such as 'utf-8' or 'latin1',
	whatever its type. Signal ZnCharacterEncodingError when its bytes are not valid in that encoding."

	^ (ZnCharacterEncoder newForEncoding: encodingName) decodeBytes:
		  (self
			   getRawFileBytes: filePath
			   ofProject: projectId
			   withParams: paramsDict)
]

{ #category : 'api' }
GitlabRepositories >> getRawFileBytes: filePath ofProject: projectId [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository
	Answer the file as a ByteArray, without decoding it."

	^ self
		  getRawFileBytes: filePath
		  ofProject: projectId
		  withParams: Dictionary new
]

{ #category : 'api' }
GitlabRepositories >> getRawFileBytes: filePath ofProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository
	Answer the file as a ByteArray, without decoding it."

	^ self
		  withContentReader: [ :entity | entity ifNotNil: [ entity bytes ] ]
		  do: [
				  self
					  getRaw: (self rawFileEndpoint: filePath ofProject: projectId)
					  withParams: paramsDict ]
]

{ #category : 'private' }
GitlabRepositories >> rawContentsOf: entity [
	"Answer the contents of entity as Zinc would: a ByteArray for a binary type, a String
	decoded with the charset of the type, or the default encoder of the client, otherwise.
	Unlike Zinc, decode with Latin-1 when the bytes are not valid in that charset,
	since Latin-1 maps every byte to a character and never fails."

	| bytes encoder |
	entity ifNil: [ ^ nil ].
	bytes := entity bytes.
	entity contentType isBinary ifTrue: [ ^ bytes ].
	encoder := entity contentType charSet
		           ifNil: [ gitlabAPI client defaultEncoder ]
		           ifNotNil: [ :charSet |
		           ZnCharacterEncoder newForEncoding: charSet ].
	^ [ encoder decodeBytes: bytes ]
		  on: ZnCharacterEncodingError
		  do: [ ZnCharacterEncoder latin1 decodeBytes: bytes ]
]

{ #category : 'private' }
GitlabRepositories >> rawFileEndpoint: filePath ofProject: projectId [

	^ '/projects/' , projectId asString , '/repository/files/'
	  , filePath encodeFilePath , '/raw'
]

{ #category : 'api' }
GitlabRepositories >> repositoryTreeOfProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repositories.html#list-repository-tree"

	| endpoint |
	endpoint := '/projects/' , projectId asString , '/repository/tree'.

	^ self getAll: endpoint withParams: paramsDict
]

{ #category : 'private' }
GitlabRepositories >> withContentReader: contentReader do: requestBlock [
	"Evaluate requestBlock, a request made with the client, reading the body of the response
	as bytes and turning it into the answer with contentReader.
	The client is shared by every resource, so restore its readers afterwards."

	| client previousReader previousContentReader |
	client := gitlabAPI client.
	previousReader := client reader.
	previousContentReader := client contentReader.
	client
		beBinary;
		contentReader: contentReader.
	^ requestBlock ensure: [
			  client
				  reader: previousReader;
				  contentReader: previousContentReader ]
]
