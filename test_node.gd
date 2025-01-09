extends Node2D

func _on_area_2d_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($view, "scale", Vector2.ONE * 1.2, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	print("entered")

func _on_area_2d_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($view, "scale", Vector2.ONE * 1.0, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
	print("exited")
