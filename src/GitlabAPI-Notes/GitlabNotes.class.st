Class {
	#name : 'GitlabNotes',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Notes',
	#package : 'GitlabAPI-Notes'
}

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
