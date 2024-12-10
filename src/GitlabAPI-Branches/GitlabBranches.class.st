Class {
	#name : 'GitlabBranches',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Branches',
	#package : 'GitlabAPI-Branches'
}

{ #category : 'api' }
GitlabBranches >> create: name inProject: projectId fromRef: ref [
	"https://docs.gitlab.com/ee/api/branches.html#create-repository-branch"

	| response |
	gitlabAPI client url:
		gitlabAPI hostUrl , '/projects/' , projectId asString , '/repository/branches'.
	gitlabAPI client queryAt: #branch put: name.
	gitlabAPI client queryAt: #ref put: ref.
	response := gitlabAPI client post.
	
	^NeoJSONReader fromString: response.
]
