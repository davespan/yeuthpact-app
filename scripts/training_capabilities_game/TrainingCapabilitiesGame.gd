extends Node

signal camera_effect

export (PackedScene) var Question
export (PackedScene) var Answer

onready var correct_sound = $CorrectSound
onready var wrong_sound = $WrongSound
onready var explosion_corrent = $ExplosionCorrect
onready var explosion_wrong = $ExplosionWrong
onready var music = $Music

var score
var q_counter

func _ready():
	data.load_data()
	randomize()

func new_game():
	score = 0
	q_counter = 0

	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$QuestionTimer.start()
	$LevelTimer.start()
	music.play()

func _on_QuestionTimer_timeout():
	show_question()
	
func show_question():
	free_scenes()
	if q_counter < quiz_data.data.size():
		var question = Question.instance()
		add_child(question)
		question.init(pick_question(q_counter))
		show_answers(q_counter)
		q_counter += 1

func pick_question(index):
	return quiz_data.data[index].question

func show_answers(index):
	var question_data = quiz_data.data[index]
	var answer_pool = question_data.choices.size()
	for i in range (answer_pool):
		var answer = Answer.instance()
		add_child(answer)
		answer.init(get_node("AnswerSpawnPositions/Position" + str(i)).position, rand_range(-0.2 * PI,  0.2 * PI), question_data.choices[i])
		answer.connect('picked', self, '_onPicked', [question_data.answer, i, index, answer])

func _onPicked(correct_answer, answer, count, sprite):
	if correct_answer == answer:
		score += 1
		correct_sound.play()
		explosion_corrent.position = sprite.position
		explosion_corrent.emitting = true
	else:
		emit_signal("camera_effect")
		wrong_sound.play()
		explosion_wrong.position = sprite.position
		explosion_wrong.emitting = true

	$HUD.update_score(score)
	
	if count == quiz_data.data.size() - 1:
		end_session()
		
	show_question()

func free_scenes():
	get_tree().call_group("answers", "queue_free")
	get_tree().call_group("question", "queue_free")

func end_session():
	free_scenes()
	_save_data()
	$LevelTimer.stop()
	$HUD.show_quiz_ending() 
	music.stop()
	
func _save_data():
	if score >= data.player.game4.high_score:
		data.player.game4.high_score = score
	if score >= 14:
		data.player.game4.completed = true
	data.save_data()

func _on_LevelTimer_timeout():
	end_session()
