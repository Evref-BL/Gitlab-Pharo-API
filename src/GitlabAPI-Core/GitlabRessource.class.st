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
GitlabRessource >> getAll: endpoint [
	| currentPage results |
	currentPage := 1.
	results := OrderedCollection new.

	[ 
	|response|
		response := self getByPage: currentPage perPage: 20 from: endpoint.
		results addAll: response.
		currentPage := currentPage + 1.
		
		response isEmpty
	] whileFalse.

	^results
	
]

{ #category : 'api' }
GitlabRessource >> getByPage: page perPage: perPage from: endpoint [
	| response |
	gitlabAPI client path: gitlabAPI hostUrl, endpoint.
	gitlabAPI client queryAt: #page put: page.
	gitlabAPI client queryAt: #per_page put: perPage.
	
	response := gitlabAPI client get.
	
	^NeoJSONReader fromString: response. 
]

{ #category : 'accessing' }
GitlabRessource >> gitlabAPI: anObject [

	gitlabAPI := anObject
]
