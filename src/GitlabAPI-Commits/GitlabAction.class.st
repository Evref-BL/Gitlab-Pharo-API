Class {
	#name : 'GitlabAction',
	#superclass : 'Object',
	#instVars : [
		'action',
		'filePath',
		'content'
	],
	#category : 'GitlabAPI-Commits',
	#package : 'GitlabAPI-Commits'
}

{ #category : 'instance creation' }
GitlabAction class >> createWithFilePath: path content: fileContent [
	^self new action: 'create'; filePath: path; content: fileContent.
]

{ #category : 'instance creation' }
GitlabAction class >> deleteWithFilePath: path [
	^self new action: 'delete'; filePath: path.
]

{ #category : 'instance creation' }
GitlabAction class >> updateWithFilePath: path content: fileContent [
	^self new action: 'update'; filePath: path; content: fileContent.
]

{ #category : 'accessing' }
GitlabAction >> action: anObject [

	action := anObject
]

{ #category : 'converting' }
GitlabAction >> asDictionary [
	| dict |
	dict := Dictionary new.
	
	dict at: #action put: action.
	dict at: #file_path put: filePath.
	
	content ifNotNil: [ dict at: #content put: content ].
	
	^dict
]

{ #category : 'accessing' }
GitlabAction >> content: anObject [

	content := anObject
]

{ #category : 'accessing' }
GitlabAction >> filePath: anObject [

	filePath := anObject
]
