Class {
	#name : 'GitlabRessource',
	#superclass : 'Object',
	#instVars : [
		'gitlabAPI'
	],
	#category : 'GitlabAPI-Core',
	#package : 'GitlabAPI-Core'
}

{ #category : 'api' }
GitlabRessource >> get: endpoint withParams: paramsDict [
	| response |
	
	gitlabAPI client path: gitlabAPI hostUrl, endpoint.
	paramsDict keysAndValuesDo: [ :key :value | gitlabAPI client queryAt: key put: value ].
	
	response := gitlabAPI client get.
	
	^NeoJSONReader fromString: response. 
	
	
]

{ #category : 'api' }
GitlabRessource >> getAll: endpoint withParams: paramsDict [
	| currentPage results |
	currentPage := 1.
	results := OrderedCollection new.
	
	[ 
	|response|
		response := self getByPage: currentPage perPage: 20 from: endpoint withParams: paramsDict.
		results addAll: response.
		currentPage := currentPage + 1.
		
		response isEmpty
	] whileFalse.

	^results
	
]

{ #category : 'api' }
GitlabRessource >> getByPage: page perPage: perPage from: endpoint withParams: paramsDict [
	| response |
	gitlabAPI client path: gitlabAPI hostUrl, endpoint.
	gitlabAPI client queryAt: #page put: page.
	gitlabAPI client queryAt: #per_page put: perPage.
	
	paramsDict keysAndValuesDo: [ :key :value | gitlabAPI client queryAt: key put: value ].
	
	response := gitlabAPI client get.
	
	^NeoJSONReader fromString: response. 
]

{ #category : 'accessing' }
GitlabRessource >> gitlabAPI: anObject [

	gitlabAPI := anObject
]

{ #category : 'api' }
GitlabRessource >> post: endpoint withData: data [
	| response |
	gitlabAPI client path: gitlabAPI hostUrl, endpoint.
	
	data keysAndValuesDo: [ :key :value | gitlabAPI client queryAt: key put: value ].
	
	response := gitlabAPI client post.
	
	^NeoJSONReader fromString: response. 
]

{ #category : 'api' }
GitlabRessource >> postJson: endpoint withData: data [
	| response |
	gitlabAPI client path: gitlabAPI hostUrl, endpoint.
	
	gitlabAPI client entity: (ZnEntity with: (NeoJSONWriter toString: data)).
	gitlabAPI client contentType: 'application/json'.
	
	response := gitlabAPI client post.
	
	^NeoJSONReader fromString: response. 
]
