Class {
	#name : 'GitlabBlames',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Blame',
	#package : 'GitlabAPI-Blame'
}

{ #category : 'api' }
GitlabBlames >> getBlameFile: filePath ofProject: projectId withParams: paramsDict [

	| endpoint  |
			
	  endpoint := '/projects/', projectId asString, '/repository/files/', filePath encodeFilePath, '/blame'.
	
	 	^self get: endpoint withParams: paramsDict   .
]
