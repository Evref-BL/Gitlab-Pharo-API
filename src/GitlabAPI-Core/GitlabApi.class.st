Class {
	#name : 'GitlabApi',
	#superclass : 'Object',
	#instVars : [
		'client',
		'hostUrl',
		'privateToken'
	],
	#category : 'GitlabAPI-Core',
	#package : 'GitlabAPI-Core'
}

{ #category : 'accessing' }
GitlabApi >> client [

	^ client
]

{ #category : 'accessing' }
GitlabApi >> hostUrl [

	^ hostUrl
]

{ #category : 'accessing' }
GitlabApi >> hostUrl: anObject [

	hostUrl := anObject
]

{ #category : 'initialization' }
GitlabApi >> initialize [
	client := (ZnClient new accept: ZnMimeType applicationJson; yourself)
]

{ #category : 'accessing' }
GitlabApi >> privateToken: anObject [ 

	client headerAt: #'PRIVATE-TOKEN' add: anObject. 
	privateToken := anObject
]

{ #category : 'ressources' }
GitlabApi >> projects [
	^GitlabProjects new gitlabAPI: self.
]
