extends CharacterBody2D

@onready var main_script = get_parent()

var damage_cooldown = 0.5 # this is in seconds
var time_since_dmg = 0.0

func _physics_process(delta):
	# Movement logic
	time_since_dmg += delta
	if Input.is_action_pressed("Right"):
		self.velocity.x = get_parent().player_speed
	elif Input.is_action_pressed("Left"):
		self.velocity.x = -get_parent().player_speed
	else:
		self.velocity.x = 0.0

	if Input.is_action_pressed("Down"):
		self.velocity.y = get_parent().player_speed
	elif Input.is_action_pressed("Up"):
		self.velocity.y = -get_parent().player_speed
	else:
		self.velocity.y = 0.0

	move_and_slide()

	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y = lerp(velocity.y, 0.0, 0.1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		GlobalScript.Damage2 += 25  # Aumentar el daño del jugador 2
		time_since_dmg = 0.0
		
		if GlobalScript.Damage2 >= 100 or GlobalScript.Damage >= 100:
			main_script.game_over()
