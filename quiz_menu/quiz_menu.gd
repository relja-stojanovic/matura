class_name Root extends Control

@onready var question_window: VBoxContainer = %QuestionWindow
@onready var correct_window: VBoxContainer = %CorrectWindow
@onready var incorrect_window: VBoxContainer = %IncorrectWindow
@onready var end_window: VBoxContainer = %EndWindow

@onready var question_label: Label = %Question
@onready var buttons: Array[AnswerButton] = [%Option1, %Option2, %Option3, %Option4, %Option5, %Option6, %Option7, %Option8]
@onready var question_confirm_button: Button = %ConfirmButton

@onready var label_correct_question: Label = %CorrectQuestion
@onready var label_correct_answer: Label = %CorrectAnswer

@onready var incorrec_question: Label = %IncorrecQuestion
@onready var incorrect_wrong_answer: Label = %IncorrectWrongAnswer
@onready var incorrect_answer: Label = %IncorrectAnswer

@onready var end_score: Label = %EndScore

func _ready() -> void:
	Global.start(self, question_label, buttons)

func _process(_delta: float) -> void:
	var i: int = buttons.size()
	for button in buttons:
		if not button.button_pressed:
			i -= 1
	question_confirm_button.disabled = i == 0

func play_correct() -> void:
	label_correct_question.text = Global.question.question
	label_correct_answer.text = ""
	for answer in Global.question.answer:
		label_correct_answer.text += Global.answers_map[answer] + "\n"
	question_window.visible = false
	correct_window.visible = true

func play_incorrect(picked: Array[Question.Option]) -> void:
	incorrec_question.text = Global.question.question
	incorrect_wrong_answer.text = ""
	for answer in picked:
		incorrect_wrong_answer.text += Global.answers_map[answer] + "\n"
	incorrect_answer.text = ""
	for answer in Global.question.answer:
		incorrect_answer.text += Global.answers_map[answer] + "\n"
	question_window.visible = false
	incorrect_window.visible = true

func play_end(correct: int, amount: int) -> void:
	var cacimeter: float = 100-(correct*100.0)/amount
	end_score.text = "%d/%d (ti si %.1f%% ćaci)" % [correct, amount, cacimeter]
	question_window.set_deferred("visible", false)
	correct_window.set_deferred("visible", false)
	incorrect_window.set_deferred("visible", false)
	end_window.visible = true

func _on_confirm_button_pressed() -> void:
	var picked: Array[Question.Option] = []
	for button in buttons:
		if button.button_pressed:
			picked.append(button.option)
	picked.sort()
	Global.pick(picked)

func _on_next_button_pressed() -> void:
	Global.play_next()
	correct_window.visible = false
	question_window.visible = true

func _on_button_pressed() -> void:
	Global.play_next()
	incorrect_window.visible = false
	question_window.visible = true

func _on_skip_button_pressed() -> void:
	Global.play_next()
