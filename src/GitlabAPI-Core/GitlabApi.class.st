Class {
	#name : 'GitlabApi',
	#superclass : 'Object',
	#instVars : [
		'client',
		'hostUrl',
		'privateToken',
		'output'
	],
	#category : 'GitlabAPI-Core',
	#package : 'GitlabAPI-Core'
}

{ #category : 'ressources' }
GitlabApi >> blames [
	^GitlabBlames new gitlabAPI: self.
]

{ #category : 'ressources' }
GitlabApi >> branches [
	^GitlabBranches new gitlabAPI: self.
]

{ #category : 'accessing' }
GitlabApi >> client [

	^ client
]

{ #category : 'accessing' }
GitlabApi >> client: anObject [

	client := anObject
]

{ #category : 'ressources' }
GitlabApi >> commits [
	^GitlabCommits new gitlabAPI: self.
]

{ #category : 'ressources' }
GitlabApi >> discussions [
	^GitlabDiscussions new gitlabAPI: self.
]

{ #category : 'ressources' }
GitlabApi >> groups [
	^GitlabGroups new gitlabAPI: self.
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

{ #category : 'ressources' }
GitlabApi >> jobs [
	^GitlabJobs new gitlabAPI: self.
]

{ #category : 'ressources' }
GitlabApi >> mergeRequests [
	^GitlabMergeRequests new gitlabAPI: self.
]

{ #category : 'ressources' }
GitlabApi >> notes [
	^GitlabNotes new gitlabAPI: self.
]

{ #category : 'accessing' }
GitlabApi >> output [

	^ output
]

{ #category : 'accessing' }
GitlabApi >> output: anObject [

	output := anObject
]

{ #category : 'ressources' }
GitlabApi >> pipelines [
	^GitlabPipelines new gitlabAPI: self.
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

{ #category : 'ressources' }
GitlabApi >> repositories [
	^GitlabRepositories new gitlabAPI: self.
]

{ #category : 'ressources' }
GitlabApi >> users [
	^GitlabUsers new gitlabAPI: self.
]
