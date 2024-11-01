extends Node2D

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("player"):
		if GlobalScript.Damage > 0:
			GlobalScript.Damage -= 5
			
			queue_free()
			
func _on_animation_player_animation_finished(anim_name: StringName):
	queue_free()
