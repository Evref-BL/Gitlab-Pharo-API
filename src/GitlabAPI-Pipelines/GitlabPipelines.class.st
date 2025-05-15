Class {
	#name : 'GitlabPipelines',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Pipelines',
	#package : 'GitlabAPI-Pipelines'
}

{ #category : 'api' }
GitlabPipelines >> getAllInProject: projectId [
	"https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines"
	
	| endpoint |
	endpoint := '/projects/', projectId asString, '/pipelines'.

	^self getAll: endpoint withParams: Dictionary new.
]

{ #category : 'api' }
GitlabPipelines >> getByPage: page perPage: perPage inProject: projectId [
	"https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines"
	
		^ self getByPage: page perPage: perPage inProject: projectId  withName: nil withOrder_by: nil  withRef: nil  withScope: nil withSha: nil withSort: nil withSource: nil  withStatus: nil updatedAfter: nil updatedAfter:  nil createdAfter: nil  createdBefore: nil
]

{ #category : 'api' }
GitlabPipelines >> getByPage: page perPage: perPage inProject: projectId createdAfter: after AndBefore: before [
	"https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines"
	
	^ self getByPage: page perPage: perPage inProject: projectId  withName: nil withOrder_by: nil  withRef: nil  withScope: nil withSha: nil withSort: nil withSource: nil  withStatus: nil updatedAfter: nil updatedAfter:  nil createdAfter: after  createdBefore: before
]

{ #category : 'api' }
GitlabPipelines >> getByPage: page perPage: perPage inProject: projectId withName: name withOrder_by: order_by withRef: ref withScope: scope withSha: sha withSort: sort withSource: source withStatus: status updatedAfter: updated_after updatedAfter: updated_before createdAfter: created_after createdBefore: created_before [
	"https://docs.gitlab.com/ee/api/pipelines.html#list-project-pipelines"
	
	| endpoint params|
	endpoint := '/projects/', projectId asString, '/pipelines'.

	params := Dictionary new.
	
	name ifNotNil: [  params at: #name put: name ].
	order_by ifNotNil: [  params at: #order_by put: order_by ].
	ref ifNotNil: [  params at: #ref put: ref ].
	scope ifNotNil: [  params at: #scope put: scope ].	
	sha ifNotNil: [  params at: #sha put: sha ].	
	sort ifNotNil: [  params at: #sort put: sort ].	
	source ifNotNil: [  params at: #source put: source ].	
	status ifNotNil: [  params at: #status put: status ].			
	updated_after ifNotNil: [  params at: #updated_after put: updated_after ].	
	updated_before ifNotNil: [  params at: #updated_before put: updated_before ].								
	created_before ifNotNil: [  params at: #created_before put: created_before ].
	created_after ifNotNil: [params at: #created_after put: created_after ].	
	
	^ self getByPage: page perPage: perPage from: endpoint withParams: params . 
]
