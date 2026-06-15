Class {
	#name : 'GitlabResource',
	#superclass : 'Object',
	#instVars : [
		'gitlabAPI',
		'itemPerPage'
	],
	#category : 'GitlabAPI-Core',
	#package : 'GitlabAPI-Core'
}

{ #category : 'initialization' }
GitlabResource >> defaultPerPageItem [

	^ 20
]

{ #category : 'api' }
GitlabResource >> get: endpoint withParams: paramsDict [

	| response |
	gitlabAPI client path: gitlabAPI hostUrl , endpoint.

	paramsDict keysAndValuesDo: [ :key :value |
		gitlabAPI client queryAt: key put: value ].

	response := gitlabAPI client get.

	gitlabAPI output = 'json' ifTrue: [ ^ response ].

	^ NeoJSONReader fromString: response
]

{ #category : 'api' }
GitlabResource >> getAll: endpoint withParams: paramsDict [

	| currentPage results |
	currentPage := 1.
	results := OrderedCollection new.

	[
	| response responseDict |
	response := self
		            getByPage: currentPage
		            perPage: itemPerPage
		            from: endpoint
		            withParams: paramsDict.
	(response isEmpty or: response = '[]') ifTrue: [ ^ results ].

	"if api return an error"
	responseDict := gitlabAPI output = 'json'
		                ifTrue: [ NeoJSONReader fromString: response ]
		                ifFalse: [ response ].
	responseDict isArray ifFalse: [ ^ response ].

	gitlabAPI output = 'json'
		ifTrue: [ results add: response ]
		ifFalse: [ results addAll: response ].
	currentPage := currentPage + 1.

	true ] whileTrue
]

{ #category : 'api' }
GitlabResource >> getByPage: page perPage: perPage from: endpoint withParams: paramsDict [

	| newParams |
	newParams := Dictionary new.
	newParams at: #page put: page.
	newParams at: #per_page put: perPage.

	paramsDict keysAndValuesDo: [ :key :value |
		newParams at: key put: value ].

	^ self get: endpoint withParams: newParams
]

{ #category : 'accessing' }
GitlabResource >> gitlabAPI: anObject [

	gitlabAPI := anObject
]

{ #category : 'initialization' }
GitlabResource >> initialize [

	itemPerPage := self defaultPerPageItem
]

{ #category : 'api' }
GitlabResource >> post: endpoint withData: data [

	| response |
	gitlabAPI client path: gitlabAPI hostUrl , endpoint.

	data keysAndValuesDo: [ :key :value |
		gitlabAPI client queryAt: key put: value ].

	response := gitlabAPI client post.

	^ NeoJSONReader fromString: response
]

{ #category : 'api' }
GitlabResource >> post: endpoint withFormData: data [

	| response |
	gitlabAPI client path: gitlabAPI hostUrl , endpoint.

	data keysAndValuesDo: [ :key :value |
		gitlabAPI client formAt: key put: value ].

	response := gitlabAPI client post.

	^ NeoJSONReader fromString: response
]

{ #category : 'api' }
GitlabResource >> postJson: endpoint withData: data [

	| response |
	gitlabAPI client path: gitlabAPI hostUrl , endpoint.

	gitlabAPI client entity:
		(ZnEntity with: (NeoJSONWriter toString: data)).
	gitlabAPI client contentType: 'application/json'.

	response := gitlabAPI client post.

	^ NeoJSONReader fromString: response
]
