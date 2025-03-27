Class {
	#name : 'GitlabBlames',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Repositories',
	#package : 'GitlabAPI-Repositories'
}

{ #category : 'api' }
GitlabBlames >> getBlameFile: filePath ofProject: projectId withParams: paramsDict [

	| endpoint  |
			
	  endpoint := '/projects/', projectId asString, '/repository/files/', filePath encodeFilePath, '/blame'.
	
	 	^self get: endpoint withParams: paramsDict   .
]
