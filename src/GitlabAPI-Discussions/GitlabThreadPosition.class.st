Class {
	#name : 'GitlabThreadPosition',
	#superclass : 'Object',
	#instVars : [
		'baseSha',
		'headSha',
		'startSha',
		'type',
		'oldPath',
		'newPath',
		'newLine',
		'oldLine',
		'startLineCode',
		'startLineType',
		'endLineCode',
		'endLineType'
	],
	#category : 'GitlabAPI-Discussions',
	#package : 'GitlabAPI-Discussions'
}

{ #category : 'instance creation' }
GitlabThreadPosition class >> createWithBaseSha: baseSha startSha: startSha headSha: headSha filePath: filePath [
	^self new baseSha: baseSha; startSha: startSha; headSha: headSha; oldPath: filePath; newPath: filePath; type: 'text'
]

{ #category : 'converting' }
GitlabThreadPosition >> asDictionary [
	| dict |
	dict := OrderedDictionary new.
	
	dict at: 'position[base_sha]' put: baseSha.
	dict at: 'position[head_sha]' put: headSha.
	dict at: 'position[start_sha]' put: startSha.
	
	dict at: 'position[position_type]' put: type.
	
	dict at: 'position[new_path]' put: newPath.
	dict at: 'position[old_path]' put: oldPath.
	
	newLine ifNotNil: [ dict at: 'position[new_line]' put: newLine ].
	oldLine ifNotNil: [ dict at: 'position[old_line]' put: oldLine ].
	
	"Line Range"
	startLineCode ifNotNil: [ dict at: 'position[line_range][start][line_code]' put: startLineCode ].
	startLineType ifNotNil: [ dict at: 'position[line_range][start][type]' put: startLineType ].
	
	endLineCode ifNotNil: [ dict at: 'position[line_range][end][line_code]' put: endLineCode ].
	endLineType ifNotNil: [ dict at: 'position[line_range][end][type]' put: endLineType ].
	
	^dict
]

{ #category : 'accessing' }
GitlabThreadPosition >> baseSha: anObject [

	baseSha := anObject
]

{ #category : 'accessing' }
GitlabThreadPosition >> headSha: anObject [

	headSha := anObject
]

{ #category : 'accessing' }
GitlabThreadPosition >> newLine: anObject [

	newLine := anObject
]

{ #category : 'accessing' }
GitlabThreadPosition >> newPath: anObject [

	newPath := anObject
]

{ #category : 'accessing' }
GitlabThreadPosition >> oldPath: anObject [

	oldPath := anObject
]

{ #category : 'initialization' }
GitlabThreadPosition >> setLineRangeFrom: startLine withType: startType to: endLine withType: endType [
  startLineCode := startLine.
  startLineType := startType.
  endLineCode := endLine.
  endLineType := endType.
]

{ #category : 'accessing' }
GitlabThreadPosition >> startSha: anObject [

	startSha := anObject
]

{ #category : 'accessing' }
GitlabThreadPosition >> type: anObject [

	type := anObject
]
