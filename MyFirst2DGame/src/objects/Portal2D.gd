tool
extends Area2D


onready var global_var = get_node("/root/GlobalVariables")
onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var player = $"/src/actors/Player.tscn"
export var next_scene: PackedScene


func _on_body_entered(body):
	#player._velocity = Vector2.ZERO
	get_node("../Player").gravity = 0
	get_node("../Player")._velocity = Vector2.ZERO
	get_node("../Player").speed = Vector2.ZERO
	teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else "" 


func teleport() -> void:
	#global_var.global_speed = 0.0
	#get_tree().paused = true
	PhysicsServer.set_active(true)
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
	#global_var.global_speed = 1.0
