extends Node2D

const SCENE_PIPE = preload("res://obj_obstacle.tscn")
var score := 0
var highscore := 0

func save_score():
	if score > highscore:
		highscore = score  # ✅ Update highscore
		var file = FileAccess.open("user://highscore.txt", FileAccess.WRITE)
		if file:
			file.store_string(str(highscore))  # ✅ Save as plain text
			file.close()
			print("Saved highscore:", highscore)

func load_score():
	var file = FileAccess.open("user://highscore.txt", FileAccess.READ)
	if file:
		var text = file.get_as_text()
		if text.is_valid_int():
			highscore = int(text)
			print("Loaded highscore:", highscore)
		else:
			print("Invalid highscore format")

func start_game():
	$CanvasLayer/scr_start.hide()
	$CanvasLayer/scr_game.show()
	$pipes.process_mode = Node.PROCESS_MODE_INHERIT
	$obj_bird.process_mode = Node.PROCESS_MODE_INHERIT

func _ready() -> void:
	load_score()
	$pipes.process_mode = Node.PROCESS_MODE_DISABLED
	$obj_bird.process_mode = Node.PROCESS_MODE_DISABLED
	$CanvasLayer/scr_game/hs_label.text = str(highscore)
	var rect = get_viewport_rect().size.x
	for pipe in $pipes.get_children():
		pipe.global_position.x +=  rect   
		pipe.set_gap()

func end_game():
	$CanvasLayer/scr_game.hide()
	$CanvasLayer/scr_gameover/Label2.text = str(score)
	if score > highscore:
		save_score()
		$CanvasLayer/scr_gameover/crown.show()
		$CanvasLayer/scr_gameover/old_score.hide()
	else:
		$CanvasLayer/scr_gameover/crown.hide()
		$CanvasLayer/scr_gameover/old_score.show()
		$CanvasLayer/scr_gameover/old_score.text = "HIGHSCORE
		" + str(highscore)
	
	$CanvasLayer/scr_gameover.show()
	
	$pipes.process_mode = Node.PROCESS_MODE_DISABLED

var pipe_speed = 3
func change_speed():
	for pipe in $pipes.get_children():
		pipe.set_speed(pipe_speed)


func add_score():
	score += 1
	$CanvasLayer/scr_game/score_label.text = str(score)
	if score % 3 == 0:
		pipe_speed += 1
		pipe_speed = min(pipe_speed , 10)
		print("pipe speed:",pipe_speed )
		change_speed()

func _on_obj_bird_area_entered(area: Area2D) -> void:
	if area.name == "mid":
		add_score()
	else:
		$obj_bird.isDead = true
		end_game()

func _on_retry_button_up() -> void:
	get_tree().reload_current_scene()


func _on_but_play_button_down() -> void:
	start_game()
