extends Node2D

func _on_area_2d_area_entered(area: Area2D):
	# Verifica que el área que entró sea un jugador
	if area.is_in_group("VersusPlayers"):
		print("Jugador encontrado: " + str(area.name))
		
		# Obtiene todos los jugadores en el grupo "VersusPlayers"
		var players = get_tree().get_nodes_in_group("VersusPlayers")
		if players.size() > 0:
			for player in players:  # Itera sobre cada jugador encontrado
				if player.has_method("activate_shield"):
					player.activate_shield()  # Activa el escudo en el jugador
					print("Escudo activado para: " + str(player.name))
					break  # Sale del bucle después de activar el escudo en el primer jugador
		else:
			print("Error: No hay jugadores en el grupo 'VersusPlayers'")

		queue_free()  # Elimina el escudo después de activarlo

func _on_animation_player_animation_finished(anim_name: StringName):
	queue_free()
