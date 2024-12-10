"
A GitlabBranchesTest is a test class for testing the behavior of GitlabBranches
"
Class {
	#name : 'GitlabBranchesTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Branches-Tests',
	#package : 'GitlabAPI-Branches-Tests'
}

{ #category : 'tests' }
GitlabBranchesTest >> testCreateInProjectFromRef [

	| hostUrl gitlabApi branchName projectId ref result client postMessage|
	
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.
	postMessage := 'success'.
	
	client stub post willReturn:  '{"message": "', postMessage, '"}'.
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	branchName := 'test'.
	projectId := 1.
	ref := 'main'.
	
	"When"
	result := gitlabApi branches create: branchName inProject: projectId fromRef: ref.
	
	"Then"
	(client request url query at: #branch) should be: branchName.
	(client request url query at: #ref) should be: ref.
	self assert: (result at: #message) equals: postMessage

]

{ #category : 'tests' }
GitlabBranchesTest >> testGetAllFromProject [

	| hostUrl gitlabApi projectId result client branch1 branch2 |
	
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	branch1 := '{"name": "branch1"}'.
	branch2 := '{"name": "branch2"}'.
	projectId := 1.
	
	(client stub get: hostUrl, '/projects/', projectId asString, '/repository/branches') willReturn: '[', branch1, ',', branch2, ']'. 
	
	"When"
	result := gitlabApi branches getAllFromProject: projectId.
	
	"Then"
	self assert: result size equals: 2.
	self assert: (result first at: #name) equals: 'branch1'.
]
