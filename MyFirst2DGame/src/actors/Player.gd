extends Actor

export var gameover_scene: PackedScene
export var stomp_impulse: = 1000.0
onready var global_var = $"/root/GlobalVariables"
onready var anim_player: AnimationPlayer = $AnimationPlayer


func _on_EnemyDetector_body_entered(body):
	#$EnemyDetector.set_deferred("monitoring", false)
	_velocity = Vector2.ZERO
	global_var.life_count -= 1
	if global_var.life_count == 0:
		#anim_player.play("fade_in")
		#yield(anim_player, "animation_finished")
		#get_tree().change_scene_to()
		get_tree().change_scene_to(gameover_scene)
		#queue_free()
	else:
		$".".position = global_var.save_point
		anim_player.play("hit_animation")
		yield(anim_player, "animation_finished")
		anim_player.play("idle_animation")
	#queue_free()



func _on_EnemyDetector_area_entered(area: Area2D):
	print("EnemyDetector_area entered")
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	

func _physics_process(delta):
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, speed, direction, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)


func player_dies():
	pass


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)


func calculate_move_velocity(
		linear_velocity: Vector2,
		speed: Vector2,
		direction: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	print(_velocity)
	return out
