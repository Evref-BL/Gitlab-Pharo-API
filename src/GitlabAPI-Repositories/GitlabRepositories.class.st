Class {
	#name : 'GitlabRepositories',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Repositories',
	#package : 'GitlabAPI-Repositories'
}

{ #category : 'api' }
GitlabRepositories >> compareInProject: projectId from: fromSHA to: toSHA [
	"https://docs.gitlab.com/ee/api/repositories.html#compare-branches-tags-or-commits"
	
	| endpoint params |
	endpoint := '/projects/', projectId asString, '/repository/compare'.
	
	params := { 
		#from -> fromSHA.
		#to  -> toSHA
	} asDictionary.
	
	^self get: endpoint withParams: params. 
]

{ #category : 'api' }
GitlabRepositories >> getRawFile: filePath ofProject: projectId [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/repository/files/', filePath encodeFilePath, '/raw'.
	
	^gitlabAPI client get: gitlabAPI hostUrl, endpoint
]

{ #category : 'api' }
GitlabRepositories >> getRawFile: filePath ofProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repository_files.html#get-raw-file-from-repository"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/repository/files/', filePath encodeFilePath, '/raw'.
	
	gitlabAPI client path: gitlabAPI hostUrl, endpoint.
	paramsDict keysAndValuesDo: [ :key :value | gitlabAPI client queryAt: key put: value ].
	
	^gitlabAPI client get.
]

{ #category : 'api' }
GitlabRepositories >> repositoryTreeOfProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/repositories.html#list-repository-tree"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/repository/tree'.
	
	^self getAll: endpoint withParams: paramsDict. 
]
