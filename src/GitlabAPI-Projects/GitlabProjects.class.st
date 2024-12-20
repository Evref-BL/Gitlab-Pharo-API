Class {
	#name : 'GitlabProjects',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Projects',
	#package : 'GitlabAPI-Projects'
}

{ #category : 'private' }
GitlabProjects >> basePath [
	^ gitlabAPI hostUrl, '/projects/' 
]

{ #category : 'api' }
GitlabProjects >> get: projectId [
	"https://docs.gitlab.com/ee/api/projects.html#get-single-project"
	| response |
	response := gitlabAPI client get: self basePath, projectId asString.

	
	^NeoJSONReader fromString: response.
]
