extends Control

func _ready():
	$Highscore.text = "Best Score: " + str(GlobalScript.highscore)
	$Score.text = "Score: " + str(GlobalScript.points)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Main/Title Screen/TitleScreen.tscn")
