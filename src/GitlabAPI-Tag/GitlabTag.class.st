Class {
	#name : 'GitlabTag',
	#superclass : 'GitlabRessource',
	#category : 'GitlabAPI-Tag',
	#package : 'GitlabAPI-Tag'
}

{ #category : 'api' }
GitlabTag >> getAllOfProject: aProjectId [
		| endpoint |
	endpoint := '/projects/' , aProjectId asString, '/repository/tags'.
	
	^self getAll: endpoint withParams: Dictionary new.
]
