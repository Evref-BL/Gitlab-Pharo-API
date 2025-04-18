Class {
	#name : 'GitlabCommits',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Commits',
	#package : 'GitlabAPI-Commits'
}

{ #category : 'api' }
GitlabCommits >> createInProject: projectId branch: branch message: message actions: gitlabActions [ 
	"https://docs.gitlab.com/ee/api/commits.html#create-a-commit-with-multiple-files-and-actions"
	
	| endpoint data |
	endpoint := '/projects/', projectId asString, '/repository/commits'.
	
	data := { 
		#branch -> branch.
		#commit_message -> message.
		#actions -> (gitlabActions collect: [:action | action asDictionary])
	} asDictionary.

	^self postJson: endpoint withData: data.
]

{ #category : 'api' }
GitlabCommits >> diffOf: commitSha inProject: projectId [
	"https://docs.gitlab.com/ee/api/commits.html#get-the-diff-of-a-commit"

	| endpoint |
	endpoint := '/projects/', projectId asString, '/repository/commits/', commitSha, '/diff'.
	
	^self get: endpoint withParams: Dictionary new.
]

{ #category : 'api' }
GitlabCommits >> diffOf: commitSha inProject: projectId uniDiff: unidiff [
	"https://docs.gitlab.com/ee/api/commits.html#get-the-diff-of-a-commit"
	| endpoint params |
	endpoint := '/projects/', projectId asString, '/repository/commits/', commitSha, '/diff'.
	
	params := { 
		#unidiff -> unidiff
	} asDictionary.
	
	^self get: endpoint withParams: params. 
]

{ #category : 'api' }
GitlabCommits >> get: commitSha inProject: projectId [
	"https://docs.gitlab.com/ee/api/commits.html#get-a-single-commit"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/repository/commits/', commitSha.
	
	^self get: endpoint withParams: Dictionary new.
]

{ #category : 'api' }
GitlabCommits >> getAllInProject: projectId [
	"https://docs.gitlab.com/ee/api/commits.html#list-repository-commits"
	
	^self getAllInProject: projectId withParams: Dictionary new.
]

{ #category : 'api' }
GitlabCommits >> getAllInProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/commits.html#list-repository-commits"
	
	^self getAll: '/projects/', projectId asString, '/repository/commits' withParams: paramsDict.
]

{ #category : 'api' }
GitlabCommits >> getByPage: page perPage: perPage inProject: projectId [
	"https://docs.gitlab.com/ee/api/commits.html#list-repository-commits"
	
	^self getByPage: page perPage: perPage inProject: projectId withParams: Dictionary new.
]

{ #category : 'api' }
GitlabCommits >> getByPage: page perPage: perPage inProject: projectId withParams: paramsDict [
	"https://docs.gitlab.com/ee/api/commits.html#list-repository-commits"
	
	^self getByPage: page perPage: perPage from: '/projects/', projectId asString, '/repository/commits'  withParams: paramsDict 
]
