Class {
	#name : 'GitlabCommits',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Commits',
	#package : 'GitlabAPI-Commits'
}

{ #category : 'api' }
GitlabCommits >> get: commitSha inProject: projectId [
	"https://docs.gitlab.com/ee/api/commits.html#get-a-single-commit"
	
	| response |
	response := gitlabAPI client get: gitlabAPI hostUrl, '/projects/', projectId asString, '/repository/commits/', commitSha.
	
	^NeoJSONReader fromString: response.
]
