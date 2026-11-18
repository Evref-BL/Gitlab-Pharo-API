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

{ #category : 'private' }
GitlabResource >> decodeFile: entity [
	"Decode a text file as UTF-8, or as Latin-1 when it is not valid UTF-8,
	since Latin-1 accepts any byte. Keep a binary file as bytes."

	entity ifNil: [ ^ nil ].
	entity contentType isBinary ifTrue: [ ^ entity bytes ].
	^ [ entity bytes utf8Decoded ]
		  on: ZnCharacterEncodingError
		  do: [ entity bytes asString ]
]

{ #category : 'initialization' }
GitlabResource >> defaultPerPageItem [

	^ 20
]

{ #category : 'api' }
GitlabResource >> get: endpoint withParams: paramsDict [

	| response |
	response := self getRaw: endpoint withParams: paramsDict.

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

{ #category : 'api' }
GitlabResource >> getFile: endpoint withParams: paramsDict [
	"For an endpoint that answers a file instead of JSON, such as a raw file.
	Answer a ByteArray for a binary file and a String for a text file, see #decodeFile:.
	The client is shared by every resource, so put its readers back afterwards."

	| client reader contentReader |
	client := gitlabAPI client.
	reader := client reader.
	contentReader := client contentReader.
	client
		beBinary;
		contentReader: [ :entity | self decodeFile: entity ].
	^ [ self getRaw: endpoint withParams: paramsDict ] ensure: [
			  client
				  reader: reader;
				  contentReader: contentReader ]
]

{ #category : 'api' }
GitlabResource >> getRaw: endpoint withParams: paramsDict [

	gitlabAPI client path: gitlabAPI hostUrl , endpoint.

	paramsDict keysAndValuesDo: [ :key :value |
		gitlabAPI client queryAt: key put: value ].

	^ gitlabAPI client get
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

	response := [ gitlabAPI client post ] ensure: [
		            gitlabAPI client resetEntity ].

	^ NeoJSONReader fromString: response
]

{ #category : 'api' }
GitlabResource >> postJson: endpoint withData: data [

	| response |
	gitlabAPI client path: gitlabAPI hostUrl , endpoint.

	gitlabAPI client entity:
		(ZnEntity with: (NeoJSONWriter toString: data)).
	gitlabAPI client contentType: 'application/json'.

	response := [ gitlabAPI client post ] ensure: [
		            gitlabAPI client resetEntity ].

	^ NeoJSONReader fromString: response
]

{ #category : 'api' }
GitlabResource >> putJson: endpoint withData: data [

	| response |
	gitlabAPI client path: gitlabAPI hostUrl , endpoint.

	gitlabAPI client entity:
		(ZnEntity with: (NeoJSONWriter toString: data)).
	gitlabAPI client contentType: 'application/json'.

	response := [ gitlabAPI client put ] ensure: [
		            gitlabAPI client resetEntity ].

	^ NeoJSONReader fromString: response
]
