Class {
	#name : 'GitlabCommits',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Commits',
	#package : 'GitlabAPI-Commits'
}

{ #category : 'as yet unclassified' }
GitlabCommits >> diffOf: commitSha inProject: projectId [
	"https://docs.gitlab.com/ee/api/commits.html#get-the-diff-of-a-commit"

	| response |
	response := gitlabAPI client get: gitlabAPI hostUrl, '/projects/', projectId asString, '/repository/commits/', commitSha, '/diff'.
	
	^NeoJSONReader fromString: response. 
]

{ #category : 'api' }
GitlabCommits >> get: commitSha inProject: projectId [
	"https://docs.gitlab.com/ee/api/commits.html#get-a-single-commit"
	
	| response |
	response := gitlabAPI client get: gitlabAPI hostUrl, '/projects/', projectId asString, '/repository/commits/', commitSha.
	
	^NeoJSONReader fromString: response.
]
