class_name VelocityAffector
extends Sprite2D

var remote_node_x
var remote_node_y

var viewport_x
var viewport_y

@export_node_path("SubViewport") var x_viewport_path
@export_node_path("SubViewport") var y_viewport_path

func _init():
	hide()

func _enter_tree():
	
	viewport_x = get_node(x_viewport_path)
	viewport_y = get_node(y_viewport_path)
	
	remote_node_x = Sprite2D.new()
	remote_node_y = Sprite2D.new()
	remote_node_x.texture = texture
	remote_node_y.texture = texture
	viewport_x.add_child(remote_node_x)
	viewport_y.add_child(remote_node_y)
	
	remote_node_x.modulate.a = 0.0
	remote_node_y.modulate.a = 0.0

func _process(_delta):
	
	var bounding_rect = get_viewport_rect()
	var transformed_position = global_position - bounding_rect.position
	transformed_position /= bounding_rect.size
	transformed_position *= 100
	
	if is_instance_valid(remote_node_x): 
		remote_node_x.position = transformed_position
		remote_node_x.scale.x = 100 / bounding_rect.size.x
		remote_node_x.scale.y = 100 / bounding_rect.size.y
		remote_node_x.modulate.r = get_parent().velocity.x + 0.5 
		remote_node_x.modulate.g = get_parent().velocity.x + 0.5 
		remote_node_x.modulate.a = abs(get_parent().velocity.x) * 0.01
		remote_node_x.scale *= get_parent().velocity.length() * 0.001
	
	if is_instance_valid(remote_node_y): 
		remote_node_y.position = transformed_position
		remote_node_y.scale.x = 100 / bounding_rect.size.x
		remote_node_y.scale.y = 100 / bounding_rect.size.y
		remote_node_y.modulate.r = get_parent().velocity.y + 0.5 
		remote_node_y.modulate.g = get_parent().velocity.y + 0.5 
		remote_node_y.modulate.a = abs(get_parent().velocity.y) * 0.01
		remote_node_y.scale *= get_parent().velocity.length() * 0.001

func _exit_tree():
	if is_instance_valid(remote_node_x): 
		remote_node_x.queue_free()
	if is_instance_valid(remote_node_y): 
		remote_node_y.queue_free()
