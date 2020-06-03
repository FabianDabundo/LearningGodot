extends NinePatchRect

onready var global_var = $"/root/GlobalVariables"
onready var lab = $Label

func _physics_process(delta):
	lab.text = str(global_var.coin_count)
	
