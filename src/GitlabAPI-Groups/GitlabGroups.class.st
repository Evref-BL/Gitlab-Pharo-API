Class {
	#name : 'GitlabGroups',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Groups',
	#package : 'GitlabAPI-Groups'
}

{ #category : 'api' }
GitlabGroups >> get: groupId [
	"https://docs.gitlab.com/ee/api/groups.html#get-a-single-group"
	
	| endpoint |
	endpoint := '/groups/', groupId asString.
	
	^self get: endpoint withParams: Dictionary new. 
]

{ #category : 'api' }
GitlabGroups >> getAll [
	"https://docs.gitlab.com/ee/api/groups.html#list-all-groups"
	
	^self getAllWithParams: Dictionary new.
]

{ #category : 'api' }
GitlabGroups >> getAllWithParams: params [
	"https://docs.gitlab.com/ee/api/groups.html#list-all-groups"
	
	| endpoint |
	endpoint := '/groups'.
	
	^self getAll: endpoint withParams: params 
]

{ #category : 'api' }
GitlabGroups >> getByPage: page perPage: perPage withParams: params [
	"https://docs.gitlab.com/ee/api/groups.html#list-all-groups"
	
	| endpoint |
	endpoint := '/groups'.
	
	^self getByPage: page perPage: perPage from: endpoint withParams: params.
]
