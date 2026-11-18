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

{ #category : 'private' }
GitlabRepositories >> decodeRawFile: entity [
	"Answer a ByteArray for a binary file and a String otherwise, as Zinc does.
	When the bytes are not valid in the charset of the file, decode them with Latin-1
	instead of failing: Latin-1 accepts any byte."

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
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository"

	| endpoint |
	endpoint := '/projects/' , projectId asString , '/repository/files/'
	            , filePath encodeFilePath , '/raw'.

	^ self readRawFile: [
		  gitlabAPI client get: gitlabAPI hostUrl , endpoint ]
]

{ #category : 'api' }
GitlabRepositories >> getRawFile: filePath ofProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository"

	| endpoint |
	endpoint := '/projects/' , projectId asString , '/repository/files/'
	            , filePath encodeFilePath , '/raw'.

	^ self readRawFile: [
			  gitlabAPI client path: gitlabAPI hostUrl , endpoint.
			  paramsDict keysAndValuesDo: [ :key :value |
				  gitlabAPI client queryAt: key put: value ].
			  gitlabAPI client get ]
]

{ #category : 'private' }
GitlabRepositories >> readRawFile: requestBlock [
	"Evaluate requestBlock with the client reading the response as bytes, decoded by #decodeRawFile:,
	so that a file that is not valid in its charset does not fail.
	The client is shared by every resource, so put its readers back afterwards."

	| client reader contentReader |
	client := gitlabAPI client.
	reader := client reader.
	contentReader := client contentReader.
	client
		beBinary;
		contentReader: [ :entity | self decodeRawFile: entity ].
	^ requestBlock ensure: [
			  client
				  reader: reader;
				  contentReader: contentReader ]
]

{ #category : 'api' }
GitlabRepositories >> repositoryTreeOfProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repositories.html#list-repository-tree"

	| endpoint |
	endpoint := '/projects/' , projectId asString , '/repository/tree'.

	^ self getAll: endpoint withParams: paramsDict
]
