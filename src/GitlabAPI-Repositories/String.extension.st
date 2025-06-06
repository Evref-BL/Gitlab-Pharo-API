Extension { #name : 'String' }

{ #category : '*GitlabAPI-Repositories' }
String >> encodeFilePath [

	| string encodedPath |
	string := (self class new: 500) writeStream.
	encodedPath := ZnUrl new encodePath: self on: string.
	^ string contents
]
