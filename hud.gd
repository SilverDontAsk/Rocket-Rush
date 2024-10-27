extends CanvasLayer


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")

	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_message_timer_timeout() -> void:
	$Message.hide()
