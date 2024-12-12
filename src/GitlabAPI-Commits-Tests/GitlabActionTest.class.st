"
A GitlabActionTest is a test class for testing the behavior of GitlabAction
"
Class {
	#name : 'GitlabActionTest',
	#superclass : 'TestCase',
	#category : 'GitlabAPI-Commits-Tests',
	#package : 'GitlabAPI-Commits-Tests'
}

{ #category : 'tests' }
GitlabActionTest >> testAsDictionary [

	"Given"
	| action filePath content gitlabAction dict |
	action := 'update'.
	filePath := 'file.txt'.
	content := 'content'.
	
	gitlabAction := GitlabAction new action: action; content: content; filePath: filePath.
	
	"When"
	dict := gitlabAction asDictionary.
	
	"Then"
	self assert: (dict at: #action) equals: action.
	self assert: (dict at: #file_path) equals: filePath.
	self assert: (dict at: #content) equals: content.
	 
]

{ #category : 'tests' }
GitlabActionTest >> testAsDictionaryWithoutParams [

	"Given"
	| action filePath gitlabAction dict |
	action := 'update'.
	filePath := 'file.txt'.
	
	gitlabAction := GitlabAction new action: action; filePath: filePath.
	
	"When"
	dict := gitlabAction asDictionary.
	
	"Then"
	self assert: (dict at: #action) equals: action.
	self assert: (dict at: #file_path) equals: filePath.
	self assert: (dict includesKey: #content) equals: false.
	 
]
