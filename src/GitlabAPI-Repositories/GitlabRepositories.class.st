Class {
	#name : 'GitlabRepositories',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Repositories',
	#package : 'GitlabAPI-Repositories'
}

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
