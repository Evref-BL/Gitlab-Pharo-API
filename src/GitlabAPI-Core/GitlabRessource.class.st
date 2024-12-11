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
