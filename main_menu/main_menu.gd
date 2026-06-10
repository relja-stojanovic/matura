extends Control

@onready var random_question: CheckBox = %RandomQuestion
@onready var random_awnser: CheckBox = %RandomAwnser
@onready var question_amount: SpinBox = %QuestionAmount

func _on_button_pressed() -> void:
	Global.random_question = random_question.button_pressed
	Global.random_awnser = random_awnser.button_pressed
	Global.question_amount = int(question_amount.value)
	get_tree().change_scene_to_file("res://quiz_menu/quiz_menu.tscn")
