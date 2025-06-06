"
A GitlabReleaseTest is a test class for testing the behavior of GitlabRelease
"
Class {
	#name : 'GitlabReleaseTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Release-Tests',
	#package : 'GitlabAPI-Release-Tests'
}

{ #category : 'tests' }
GitlabReleaseTest >> testGetLatestOfProject [

		| hostUrl gitlabApi result client endpoint projectId release api |
	
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.
	
	gitlabApi := GitlabApi new privateToken: 'token'; hostUrl: hostUrl; client: client.
	
	projectId := 1.
	
	release := { #tag_name -> 'v1.3.4' .
					#message -> 'message'} asDictionary.

	
	api := GitlabRelease new gitlabAPI: gitlabApi.
	
	endpoint := '/projects/{1}/releases/permalink/latest' format: {projectId asString}.
	(api stub get: endpoint withParams: Dictionary new) willReturn: release.
	
	"When"
	result := api getLatestOfProject: projectId.
	
	"Then"
	self assert: result  equals: release.
]
