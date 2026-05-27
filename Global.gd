extends Node

var questions: Array[Question] = [
	preload("res://questions/os_1.tres"),
	preload("res://questions/os_2.tres"),
	preload("res://questions/os_3.tres"),
	preload("res://questions/os_4.tres"),
	preload("res://questions/os_5.tres"),
	preload("res://questions/os_6.tres"),
	preload("res://questions/os_7.tres"),
	preload("res://questions/os_8.tres"),
	preload("res://questions/os_9.tres"),
	preload("res://questions/os_10.tres"),
	preload("res://questions/os_11.tres"),
	preload("res://questions/os_12.tres"),
	preload("res://questions/os_13.tres"),
	preload("res://questions/os_14.tres"),
	preload("res://questions/os_15.tres"),
	preload("res://questions/os_16.tres"),
	preload("res://questions/os_17.tres"),
	preload("res://questions/os_18.tres"),
	preload("res://questions/os_19.tres"),
	preload("res://questions/os_20.tres"),
	preload("res://questions/os_21.tres"),
	preload("res://questions/os_22.tres"),
	preload("res://questions/os_23.tres"),
	preload("res://questions/os_24.tres"),
	preload("res://questions/os_25.tres"),
	preload("res://questions/os_26.tres"),
	preload("res://questions/os_27.tres"),
	preload("res://questions/os_28.tres"),
	preload("res://questions/os_29.tres"),
	preload("res://questions/os_30.tres"),
	preload("res://questions/os_31.tres"),
	preload("res://questions/os_32.tres"),
	preload("res://questions/os_33.tres"),
	preload("res://questions/os_34.tres"),
	preload("res://questions/os_35.tres"),
	preload("res://questions/os_36.tres"),
	preload("res://questions/os_37.tres"),
	preload("res://questions/os_38.tres"),
	preload("res://questions/os_39.tres"),
	preload("res://questions/os_40.tres"),
	preload("res://questions/os_41.tres"),
	preload("res://questions/os_42.tres"),
	preload("res://questions/os_43.tres"),
	preload("res://questions/os_44.tres"),
	preload("res://questions/os_45.tres"),
	preload("res://questions/os_46.tres"),
	preload("res://questions/os_47.tres"),
	preload("res://questions/os_48.tres"),
	preload("res://questions/os_49.tres"),
	preload("res://questions/td_1.tres"),
	preload("res://questions/td_2.tres"),
	preload("res://questions/td_3.tres"),
	preload("res://questions/td_4.tres"),
	preload("res://questions/td_5.tres"),
	preload("res://questions/td_6.tres"),
	preload("res://questions/td_7.tres"),
	preload("res://questions/td_8.tres"),
	preload("res://questions/td_9.tres"),
	preload("res://questions/td_10.tres"),
	preload("res://questions/td_11.tres"),
	preload("res://questions/td_12.tres"),
	preload("res://questions/td_13.tres"),
	preload("res://questions/td_14.tres"),
	preload("res://questions/td_15.tres"),
	preload("res://questions/td_16.tres"),
	preload("res://questions/td_17.tres"),
	preload("res://questions/td_18.tres"),
	preload("res://questions/td_19.tres"),
	preload("res://questions/td_20.tres"),
	preload("res://questions/td_21.tres"),
	preload("res://questions/td_22.tres"),
	]
var question_index: int = -1

var question: Question 
var answers_map: Dictionary[Question.Option, String]
var shuffled_options: Array[Question.Option]

var root: Root
var question_label: Label
var buttons: Array[AnswerButton]
var correct: int

func start(init_root: Root, label: Label, init_buttons: Array[AnswerButton]) -> void:
	root = init_root
	question_label = label
	buttons = init_buttons
	correct = 0
	
	questions.shuffle()
	Global.play_next()

func play_next() -> void:
	question_index += 1
	if question_index == questions.size():
		root.play_end(correct, questions.size())
		return
	play(questions[question_index])

func play(next_question: Question) -> void:
	question = next_question
	answers_map = {
		Question.Option.A: question.a,
		Question.Option.B: question.b,
		Question.Option.C: question.c,
		Question.Option.D: question.d,
		Question.Option.E: question.e,
		Question.Option.F: question.f,
		Question.Option.G: question.g,
		Question.Option.H: question.h
	}
	shuffled_options = answers_map.keys()
	shuffled_options.shuffle()
	
	question_label.text = question.question
	for i in range(buttons.size()):
		set_button(buttons[i], i)

func set_button(button: AnswerButton, index: int) -> void:
	button.text = answers_map[shuffled_options[index]]
	button.option = shuffled_options[index]
	button.button_pressed = false
	button.visible = not answers_map[shuffled_options[index]].is_empty()
	button.disabled = answers_map[shuffled_options[index]].is_empty()

func pick(picked: Array[Question.Option]) -> void:
	if picked == question.answer:
		correct += 1
		root.play_correct()
	else:
		root.play_incorrect(picked)
