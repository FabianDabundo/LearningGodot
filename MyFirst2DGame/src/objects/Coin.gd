extends Area2D

onready var global_var = get_node("/root/GlobalVariables")
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func _on_body_entered(body):
	#get_node("CollisionShape2D").disabled = true
	$CollisionShape2D.set_deferred("disabled", true)
	anim_player.play("fade_out")
	global_var.coin_count += 1
	#print(global_var.coin_count)
	yield(anim_player, "animation_finished")
	queue_free()

