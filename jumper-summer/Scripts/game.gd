extends Node2D

func _ready() -> void:
	get_tree().paused = false
	$CanvasLayer/Fade_transition.hide()
	$CanvasLayer/Tracker/HBoxContainer/Flag1.modulate.a = 0.25
	$CanvasLayer/Tracker/HBoxContainer/Flag2.modulate.a = 0.25
	$CanvasLayer/Tracker/HBoxContainer/Flag3.modulate.a = 0.25
	$CanvasLayer/Tracker/HBoxContainer/Flag4.modulate.a = 0.25
	$CanvasLayer/Water_transition/AnimatedSprite2D.play("fade_out")
	await $CanvasLayer/Water_transition/AnimatedSprite2D.animation_finished
	$CanvasLayer/Water_transition.hide()

func _process(delta: float) -> void:
	pass

func _on_create_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("Crate"):
		body.collision_layer = 1
		body.collision_mask = 1 

func _on_create_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("Crate"):
		body.collision_layer = 2
		body.collision_mask = 2

func _on_fall_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.respawn()

func _on_flag_1_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$CanvasLayer/Tracker/HBoxContainer/Flag1.modulate.a = 1.00

func _on_water_1_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$map/Particles/Water1OneShot.emitting = true
		body.respawn()

func _on_water_1_killzone_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$map/Particles/Water1OneShot2.emitting = true
		body.respawn()
