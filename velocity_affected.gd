extends Sprite2D

func _ready():
	material = material.duplicate()

func _process(delta):
	material.set_shader_parameter("world_uv", global_position / get_viewport_rect().size)
