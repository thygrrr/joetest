class_name Hand
extends Node3D

@onready var camera := $".." as Camera3D

func _ready() -> void:
	update_fan()

func update_fan():
	var cards : Array[Card] = []
	for child in get_children():
		if child is Card:
			cards.append(child)

	var count := len(cards)

	var offset = -(count)/2

	for card in cards:
		var area : Area3D = card.get_node("Area3D")
		card.position = Vector3(offset * -3, -abs(offset*0.2), 0);
		card.rotation_degrees = Vector3(0, 0, offset * 4)
		offset += 1


func _process(_delta: float) -> void:
		var mouse_pos := get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(mouse_pos)
		var to = from + camera.project_ray_normal(mouse_pos) * 50

		var ray = PhysicsRayQueryParameters3D.new()
		ray.collide_with_areas = true
		ray.from = from
		ray.to = to

		var hit := get_world_3d().direct_space_state.intersect_ray(ray)

		var card : Card = null
		var closest := INF

		if hit:
			var candidate = hit.collider.get_parent() as Card
			if candidate and candidate.get_parent() == self:
				for child in get_children():
					if child is Card:
						var distance = get_distance_to_ray(from, to, child.global_position)
						if distance < closest:
							closest = distance
							card = child

		if card:
			card._on_mouse_entered()
		elif Card.hovered and Card.hovered.get_parent() == self:
			Card.hovered._on_mouse_exited()


func get_distance_to_ray(ray_from: Vector3, ray_to: Vector3, point: Vector3) -> float:
	# Get ray direction
	var ray_dir = (ray_to - ray_from).normalized()

	# Vector from ray start to the point
	var point_vector = point - ray_from

	# Project point_vector onto the ray direction
	var projection = point_vector.dot(ray_dir) * ray_dir

	# Get perpendicular vector (this is the shortest path from point to ray)
	var perpendicular = point_vector - projection

	# Return length of perpendicular vector
	return perpendicular.length()
