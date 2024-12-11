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
GitlabCommitsTest >> testDiffOfInProject [

	| hostUrl gitlabApi projectId result client commitId diffContent1 diff1 diffContent2 diff2 path |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	commitId:= '1aert14'.
	projectId := 1.
	
	diffContent1 := 'diff1'.
	diff1 := '{ "diff": "', diffContent1 ,'"}'.
	diffContent2 := 'diff2'.
	diff2 := '{ "diff": "', diffContent2 ,'" }'.
	
	path := hostUrl, '/projects/', projectId asString, '/repository/commits/', commitId, '/diff'.
	
	(client stub get: path) willReturn: '[ ', diff1, ',', diff2, ']'. 
	
	"When"
	result := gitlabApi commits diffOf: commitId inProject: projectId.
	
	"Then"
	self assert: result size equals: 2.
	self assert: (result first at: #diff) equals: diffContent1.
	self assert: (result last at: #diff) equals: diffContent2.
]

{ #category : 'tests' }
GitlabCommitsTest >> testDiffOfInProjectUniDiff [
	| hostUrl gitlabApi projectId result client commitId diffContent1 diff1 diffContent2 diff2 path uniDiff |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	commitId:= '1aert14'.
	projectId := 1.
	uniDiff := true.
	
	diffContent1 := 'diff1'.
	diff1 := '{ "diff": "', diffContent1 ,'"}'.
	diffContent2 := 'diff2'.
	diff2 := '{ "diff": "', diffContent2 ,'" }'.
	
	path := hostUrl, '/projects/', projectId asString, '/repository/commits/', commitId, '/diff'.
	
	(client stub get: path) willReturn: '[ ', diff1, ',', diff2, ']'.
	
	"When"
	result := gitlabApi commits diffOf: commitId inProject: projectId uniDiff: uniDiff.
	
	"Then"
	self assert: (client request url query at: #unidiff) equals: uniDiff asString.
	self assert: result size equals: 2.
	self assert: (result first at: #diff) equals: diffContent1.
	self assert: (result last at: #diff) equals: diffContent2.
]

{ #category : 'tests' }
GitlabCommitsTest >> testGetAllInProject [
	| hostUrl gitlabApi result client objectId object endpoint projectId gitlabCommits |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString, '/repository/commits'.
	(gitlabCommits stub getAll: endpoint) willReturn: { object }.
	
	"When"
	result := gitlabCommits getAllInProject: projectId.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

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
