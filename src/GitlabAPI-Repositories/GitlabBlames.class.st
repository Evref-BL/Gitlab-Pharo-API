Class {
	#name : 'GitlabBlames',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Repositories',
	#package : 'GitlabAPI-Repositories'
}

{ #category : 'api' }
GitlabBlames >> getBlameOf: filePath inRef: ref ofProject: projectId [

	| endpoint params  |
		params := { 
		    #ref ->   ref  .
	       } asDictionary.		
	  endpoint := '/projects/', projectId asString, '/repository/files/', filePath encodeFilePath, '/blame'.
	
	 	^self get: endpoint withParams: params   .
]

{ #category : 'api' }
GitlabBlames >> getBlameOf: filePath inRef: ref withRange:gitlabRange ofProject:projectId [
	| endpoint params  |
		params := { 
		    #ref ->   ref  .
		    #range -> gitlabRange 
	       } asDictionary.		
	  endpoint := '/projects/', projectId asString, '/repository/files/', filePath encodeFilePath, '/blame'.
	
	 	^self get: endpoint withParams: params   .
]
