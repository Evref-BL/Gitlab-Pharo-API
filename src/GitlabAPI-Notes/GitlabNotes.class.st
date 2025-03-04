Class {
	#name : 'GitlabNotes',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Notes',
	#package : 'GitlabAPI-Notes'
}

{ #category : 'api - get' }
GitlabNotes >> allInMergeRequest: mergeRequestIID ofProject: projectId [
	"https://docs.gitlab.com/api/notes/#list-all-merge-request-notes"
	
	| endpoint |
	endpoint := '/projects/' , projectId asString, '/merge_requests/', mergeRequestIID asString, '/notes'.
	
	^self getAll: endpoint withParams: Dictionary new.
]

{ #category : 'api - get' }
GitlabNotes >> allInMergeRequest: mergeRequestIID ofProject: projectId withParams: params [
	"https://docs.gitlab.com/api/notes/#list-all-merge-request-notes"
	
	| endpoint |
	endpoint := '/projects/' , projectId asString, '/merge_requests/', mergeRequestIID asString, '/notes'.
	
	^self getAll: endpoint withParams: params.
]

{ #category : 'api' }
GitlabNotes >> createInMergeRequest: mergeRequestIID ofProject: projectId withBody: body [
	"https://docs.gitlab.com/ee/api/notes.html#create-new-merge-request-note"
	
	| endpoint data |
	endpoint := '/projects/' , projectId asString, '/merge_requests/', mergeRequestIID asString, '/notes'.
	
	data := { 
		#body -> body 
	} asDictionary.
	
	^self post: endpoint withData: data. 
]
