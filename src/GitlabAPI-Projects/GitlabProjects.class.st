Class {
	#name : 'GitlabProjects',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Projects',
	#package : 'GitlabAPI-Projects'
}

{ #category : 'api' }
GitlabProjects >> all [
	"https://docs.gitlab.com/ee/api/projects.html#list-all-projects"
	^self allWithParams: Dictionary new.
]

{ #category : 'api' }
GitlabProjects >> allWithParams: paramsDict [
	"https://docs.gitlab.com/ee/api/projects.html#list-all-projects"
	
	| endpoint |
	endpoint := '/projects'.
	
	^self getAll: endpoint withParams: paramsDict. 
]

{ #category : 'api' }
GitlabProjects >> contributedProjectsOfUser: userId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/projects.html#list-projects-a-user-has-contributed-to"

	| endpoint |
	endpoint := '/users/', userId asString, '/contributed_projects'.
	
	^self getAll: endpoint withParams: paramsDict. 
]

{ #category : 'api' }
GitlabProjects >> get: projectId [
	"https://docs.gitlab.com/ee/api/projects.html#get-single-project"
	| endpoint |
	endpoint := '/projects/', projectId asString.

	^self get: endpoint withParams: Dictionary new.
]
