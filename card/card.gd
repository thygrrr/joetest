# SPDX-License-Identifier: Unlicense
@icon("res://card/icon.svg")
class_name Card
extends Node3D

var tween : Tween

static var hovered : Card = null

func _enter_tree() -> void:
	$Area3D.set_block_signals(get_parent_node_3d() is Hand)


func _on_mouse_entered() -> void:
	if (hovered == self):
		return

	if (hovered != null):
		hovered._on_mouse_exited()

	hovered = self
	if tween:
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property($View, "scale", Vector3.ONE * 1.1, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	$View.sorting_offset = 10000
	$View.modulate = Color.WHITE


func _on_mouse_exited() -> void:
	if tween:
		tween.stop()
	tween = get_tree().create_tween()
	tween.tween_property($View, "scale", Vector3.ONE * 1.0, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	position.z = 0
	$View.modulate = Color.GRAY
	$View.sorting_offset = 100 - get_index()

	if (hovered == self):
		hovered = null
