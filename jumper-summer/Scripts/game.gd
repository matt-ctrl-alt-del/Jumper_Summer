extends Node2D

func _ready() -> void:
	get_tree().paused = false
	$CanvasLayer/Fade_transition.hide()
	$CanvasLayer/Water_transition/AnimatedSprite2D.play("fade_out")
	await $CanvasLayer/Water_transition/AnimatedSprite2D.animation_finished
	$CanvasLayer/Water_transition.hide()

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().paused = true
	$player/Camera2D.zoom = Vector2.ONE * 5
	await get_tree().create_timer(1.0).timeout
	$player/Camera2D.zoom = Vector2.ONE * 7
	await get_tree().create_timer(1.0).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_create_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Crate"):
		body.collision_layer = 1
		body.collision_mask = 1 

func _on_create_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Crate"):
		body.collision_layer = 2
		body.collision_mask = 2
