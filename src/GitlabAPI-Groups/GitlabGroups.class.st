Class {
	#name : 'GitlabGroups',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Groups',
	#package : 'GitlabAPI-Groups'
}

{ #category : 'private - requesting' }
GitlabGroups >> get: groupId [
	"https://docs.gitlab.com/ee/api/groups.html#get-a-single-group"
	
	| endpoint |
	endpoint := '/groups/', groupId asString.
	
	^self get: endpoint withParams: Dictionary new. 
]
