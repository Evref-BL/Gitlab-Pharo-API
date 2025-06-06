Class {
	#name : 'GitlabRelease',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Release',
	#package : 'GitlabAPI-Release'
}

{ #category : 'as yet unclassified' }
GitlabRelease >> getAllOfProject: aProjectId [ 	
	
	^ self getAllOfProject: aProjectId withParams: Dictionary new
]

{ #category : 'as yet unclassified' }
GitlabRelease >> getAllOfProject: aProjectId forTagName: aTagName [ 
	^ self getAllOfProject: aProjectId forTagName: aTagName withParams: Dictionary new 
]

{ #category : 'as yet unclassified' }
GitlabRelease >> getAllOfProject: aProjectId forTagName: aTagName withParams: aParmDictionnary [
	|endpoint|
	endpoint := '/projects/{1}/releases/{2}' format: { aProjectId asString . aTagName asString}.
	^ self get: endpoint withParams: aParmDictionnary. 
]

{ #category : 'as yet unclassified' }
GitlabRelease >> getAllOfProject: aProjectId withParams: aParmDictionnary [
	|endpoint|
	endpoint := '/projects/{1}/releases' format: { aProjectId asString }.
	^ self get: endpoint withParams: aParmDictionnary. 
]

{ #category : 'as yet unclassified' }
GitlabRelease >> getLatestOfProject: aProjectId [
	|endpoint|
	
	endpoint := '/projects/{1}/releases/permalink/latest' format: { aProjectId asString }.
	
	^ self get: endpoint withParams: Dictionary new. 
]
