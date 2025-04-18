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
GitlabCommitsTest >> testCreateInProjectBranchMessageActions [
	| hostUrl gitlabApi projectId result client branch message actions endpoint data response gitlabCommits |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	projectId := 1.
	branch := 'branch'.
	message := 'message'.
	actions := { 
		GitlabAction createWithFilePath: 'file.txt' content: 'content' 
	}.
	
	endpoint := '/projects/', projectId asString, '/repository/commits'.
	
	data := { 
		#branch -> branch.
		#commit_message -> message.
		#actions -> (actions collect: [ :action | action asDictionary ]).	
	} asDictionary.
	
	
	response := { 
		#message -> 'message'
	} asDictionary.
	
	(gitlabCommits stub postJson: endpoint withData: data) willReturn: response.
	
	"When"
	result := gitlabCommits createInProject: projectId branch: branch  message: message  actions: actions. 
	
	"Then"
	self assert: (result at: #message) equals: (response at: #message).
]

{ #category : 'tests' }
GitlabCommitsTest >> testDiffOfInProject [

	| hostUrl gitlabApi projectId result client commitId diffContent1 diff1 diffContent2 diff2 path gitlabCommits |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	commitId:= '1aert14'.
	projectId := 1.
	
	diffContent1 := 'diff1'.
	diff1 := { 
		#diff -> diffContent1 
	} asDictionary.
	
	diffContent2 := 'diff2'.
	diff2 := { 
		#diff -> diffContent2 
	} asDictionary.
	
	path := '/projects/', projectId asString, '/repository/commits/', commitId, '/diff'.
	
	(gitlabCommits stub get: path withParams: Dictionary new) willReturn: {diff1 . diff2}.
	
	"When"
	result := gitlabCommits diffOf: commitId inProject: projectId.
	
	"Then"
	self assert: result size equals: 2.
	self assert: (result first at: #diff) equals: diffContent1.
	self assert: (result last at: #diff) equals: diffContent2.
]

{ #category : 'tests' }
GitlabCommitsTest >> testDiffOfInProjectUniDiff [
	| hostUrl gitlabApi projectId result client commitId diffContent1 diff1 diffContent2 diff2 path uniDiff gitlabCommits params |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	commitId:= '1aert14'.
	projectId := 1.
	uniDiff := true.
	
	params := { 
		#unidiff -> uniDiff
	} asDictionary.
	
	diffContent1 := 'diff1'.
	diff1 := { 
		#diff -> diffContent1 
	} asDictionary.
	
	diffContent2 := 'diff2'.
	diff2 := { 
		#diff -> diffContent2 
	} asDictionary.
	
	path := '/projects/', projectId asString, '/repository/commits/', commitId, '/diff'.
	
	(gitlabCommits stub get: path withParams: params) willReturn: {diff1 . diff2}.
	
	"When"
	result := gitlabCommits diffOf: commitId inProject: projectId uniDiff: uniDiff.
	
	"Then"
	self assert: result size equals: 2.
	self assert: (result first at: #diff) equals: diffContent1.
	self assert: (result last at: #diff) equals: diffContent2.
]

{ #category : 'tests' }
GitlabCommitsTest >> testGetAllInProject [
	| hostUrl gitlabApi result client objectId object projectId gitlabCommits |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	(gitlabCommits stub getAllInProject: projectId withParams: Dictionary new) willReturn: { object }.
	
	"When"
	result := gitlabCommits getAllInProject: projectId.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabCommitsTest >> testGetAllInProjectWithParams [

	| hostUrl gitlabApi result client objectId object endpoint projectId gitlabCommits params |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	params := { 'param' -> 'value' } asDictionary.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString, '/repository/commits'.
	(gitlabCommits stub getAll: endpoint withParams: params) willReturn: { object }.
	
	"When"
	result := gitlabCommits getAllInProject: projectId withParams: params.
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabCommitsTest >> testGetByPagePerPageInProject [
	| hostUrl gitlabApi result client objectId object endpoint projectId gitlabCommits page perPage |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	page := 1.
	perPage := 3.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString, '/repository/commits'.
	(gitlabCommits stub getByPage: page perPage: perPage  inProject: projectId withParams: Dictionary new) willReturn: { object }.
	
	"When"
	result := gitlabCommits getByPage: page perPage: perPage inProject: projectId. 
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabCommitsTest >> testGetByPagePerPageInProjectWithParams [

	| hostUrl gitlabApi result client objectId object endpoint projectId gitlabCommits params page perPage |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	page := 1.
	perPage := 3.
	params := { 'param' -> 'value' } asDictionary.
	
	objectId := 1.
	object := { #id -> objectId } asDictionary.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/', projectId asString, '/repository/commits'.
	(gitlabCommits stub getByPage: page perPage: perPage  from: endpoint withParams: params) willReturn: { object }.
	
	"When"
	result := gitlabCommits getByPage: page perPage: perPage inProject: projectId withParams: params. 
	
	"Then"
	self assert: result size equals: 1.
	self assert: (result first at: #id) equals: objectId.
]

{ #category : 'tests' }
GitlabCommitsTest >> testGetInProject [

	| hostUrl gitlabApi projectId result client commitId gitlabCommits endpoint commit |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	gitlabCommits := GitlabCommits new gitlabAPI: gitlabApi.
	
	commitId:= '1aert14'.
	projectId := 1.
	
	commit := { 
		#id -> 4
	} asDictionary.
	
	endpoint := '/projects/', projectId asString, '/repository/commits/', commitId.
	(gitlabCommits stub get: endpoint withParams: Dictionary new) willReturn: commit. 
	
	"When"
	result := gitlabCommits get: commitId inProject: projectId.
	
	"Then"
	self assert: result equals: commit.
]
