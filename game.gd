extends Node
@export var obs_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_character_hit() -> void:
	pass # Replace with function body.

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$MainCharacter.start($StartPosition.position)
	$StartTimer.start()

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout() -> void:
	var obs = obs_scene.instantiate()
	var obs_spawn_location = $ObsPath/ObsSpawnLoc
	obs_spawn_location.progress_ratio = randf()
	var direction = obs_spawn_location.rotation + PI / 2
	obs.position = obs_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	obs.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	
	add_child(obs)

func _on_score_timer_timeout() -> void:
	score += 1
