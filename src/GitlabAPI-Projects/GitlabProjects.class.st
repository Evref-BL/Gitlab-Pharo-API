Class {
	#name : 'GitlabProjects',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Projects',
	#package : 'GitlabAPI-Projects'
}

{ #category : 'api' }
GitlabProjects >> allWithParams: paramsDict [
	"https://docs.gitlab.com/ee/api/projects.html#list-all-projects"
	
	| endpoint |
	endpoint := '/projects'.
	
	^self getAll: endpoint withParams: paramsDict. 
]

{ #category : 'private' }
GitlabProjects >> basePath [
	^ gitlabAPI hostUrl, '/projects/' 
]

{ #category : 'api' }
GitlabProjects >> get: projectId [
	"https://docs.gitlab.com/ee/api/projects.html#get-single-project"
	| endpoint |
	endpoint := '/projects/', projectId asString.

	^self get: endpoint withParams: Dictionary new.
]
