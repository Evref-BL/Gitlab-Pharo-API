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
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository"

	^ self
		  getRawFile: filePath
		  ofProject: projectId
		  withParams: Dictionary new
]

{ #category : 'api' }
GitlabRepositories >> getRawFile: filePath ofProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository"

	| endpoint |
	endpoint := '/projects/' , projectId asString , '/repository/files/'
	            , filePath encodeFilePath , '/raw'.

	^ self getFile: endpoint withParams: paramsDict
]

{ #category : 'api' }
GitlabRepositories >> repositoryTreeOfProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repositories.html#list-repository-tree"

	| endpoint |
	endpoint := '/projects/' , projectId asString , '/repository/tree'.

	^ self getAll: endpoint withParams: paramsDict
]
