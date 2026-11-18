extends Node2D


func _ready() -> void:
	get_tree().paused = false
	$CanvasLayer/Fade_transition.hide()
	$CanvasLayer/Water_transition/AnimatedSprite2D.play("fade_out")
	await $CanvasLayer/Water_transition/AnimatedSprite2D.animation_finished
	$CanvasLayer/Water_transition.hide()


func _process(delta: float) -> void:
	pass
