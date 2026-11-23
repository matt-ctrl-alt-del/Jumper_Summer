extends CharacterBody2D

var gravity := 18.5
var jump_height = -360.0
var wind_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var input_x: float = Input.get_axis("move_left", "move_right")
	velocity.x = input_x * get_player_speed()
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_height
	
	velocity.y += gravity if wind_velocity.y == 0.0 else 0.0
	velocity += wind_velocity * 0.4
	move_and_slide()
	$AnimatedSprite2D.play(frame_animation())

func get_player_speed() -> float:
	if Input.is_action_pressed("sprint"):
		return 130.0
	if Input.is_action_pressed("move_down") and is_on_floor():
			return 25.0
	return 110.0

func frame_animation() -> String: 
	var is_moving: bool = velocity.x != 0
	if is_moving:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	if !is_on_floor() and velocity.y < 0:
		return "jump"
	
	if is_moving:
		if Input.is_action_pressed("sprint"):
			return "walk"
		if Input.is_action_pressed("move_down"):
			return "crouch_walk"
		return "walk"
		
	if Input.is_action_pressed("move_down"):
		return "crouch_walk"
	return "walk"

func respawn():
	get_tree().paused = true
	$AnimatedSprite2D.play("die")
	$AudioStreamPlayer.playing = true
	await $AnimatedSprite2D.animation_finished
	$Camera2D.zoom = Vector2.ONE * 5
	await get_tree().create_timer(1.0).timeout
	$Camera2D.zoom = Vector2.ONE * 7
	await get_tree().create_timer(1.0).timeout
	get_tree().paused = false
	$Camera2D.zoom = Vector2.ONE * 3
	self.global_position = Vector2(36.0, 77.0)
