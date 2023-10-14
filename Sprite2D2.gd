extends CharacterBody2D

func _process(delta):
	
	velocity += Input.get_vector("ui_left", "ui_right", "ui_up",  "ui_down") * 100
	velocity *= 0.9
	
	move_and_slide()
