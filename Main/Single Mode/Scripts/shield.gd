extends Node2D

func _on_area_2d_area_entered(area: Area2D):
	# Verifica que el área que entró sea un jugador
	if area.is_in_group("player"):
		print("Jugador encontrado: " + str(area.name))
		var players = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			players[0].activate_shield() # Activa el escudo en el jugador
		queue_free()  # Elimina el escudo después de activarlo
		
func _on_animation_player_animation_finished(anim_name: StringName):
	queue_free()
