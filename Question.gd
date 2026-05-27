class_name Question extends Resource

enum Option {
	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H
	}

@export_multiline var question: String 
@export var a: String
@export var b: String
@export var c: String
@export var d: String
@export var e: String
@export var f: String
@export var g: String
@export var h: String
@export var answer: Array[Option] = [Option.A]
