extends Control


func _ready() -> void:
	$ColorRect/AnimatedSprite2D.play("default")
	await $ColorRect/AnimatedSprite2D.animation_finished
	$ColorRect/AnimatedSprite2D.hide()
	$ColorRect/AnimatedSprite2D2.play("default")
	await $ColorRect/AnimatedSprite2D2.animation_finished
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _process(delta: float) -> void:
	pass
