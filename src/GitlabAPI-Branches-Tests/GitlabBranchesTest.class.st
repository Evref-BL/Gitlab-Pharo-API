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
