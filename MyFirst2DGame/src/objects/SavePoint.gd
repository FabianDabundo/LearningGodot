extends Area2D

onready var global_var = $"/root/GlobalVariables"

func _on_SavePoint_body_entered(body):
	global_var.save_point = $".".position
	print(str(global_var.save_point))
