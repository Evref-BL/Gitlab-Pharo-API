"
A GitlabCommitsTest is a test class for testing the behavior of GitlabCommits
"
Class {
	#name : 'GitlabCommitsTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Commits-Tests',
	#package : 'GitlabAPI-Commits-Tests'
}

{ #category : 'tests' }
GitlabCommitsTest >> testGetInProject [

	| hostUrl gitlabApi projectId result client commitId |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	commitId:= '1aert14'.
	projectId := 1.
	
	(client stub get: hostUrl, '/projects/', projectId asString, '/repository/commits/', commitId) willReturn: '{ "id": "', commitId, '" }'. 
	
	"When"
	result := gitlabApi commits get: commitId inProject: projectId.
	
	"Then"
	self assert: (result at: #id) equals: commitId.
]
