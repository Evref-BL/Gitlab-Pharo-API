Class {
	#name : 'GitlabUsers',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Users',
	#package : 'GitlabAPI-Users'
}

{ #category : 'api' }
GitlabUsers >> allWithParams: paramsDict [
	"https://docs.gitlab.com/ee/api/users.html#list-users"
	
	| endpoint |
	endpoint := '/users'.
	
	^self getAll: endpoint withParams: paramsDict. 
]

{ #category : 'api' }
GitlabUsers >> get: userId [
	"https://docs.gitlab.com/ee/api/users.html#get-a-single-user"

	| endpoint |
	endpoint := '/users/', userId asString.
	
	^self get: endpoint withParams: Dictionary new.
]
