extends Node2D

@export var box_node: PackedScene
var box_left
var box_right

var start_pos_left = Vector2(180, 70)
var start_pos_right = Vector2(580, 70)

func _ready():
	if box_node != null:
		_spawn_boxes()
	else:
		print("ERROR: box_node PackedScene is null!")

func _spawn_boxes():
	await _spawn_box_left()
	await _spawn_box_right()
	await get_tree().create_timer(2).timeout

func _spawn_box_left():
	if box_left != null:
		await box_left.tree_exited
	box_left = box_node.instantiate()
	box_left.position = start_pos_left
	box_left.call_deferred("set_name", "BoxLeft")
	box_left.next_box.connect(_on_next_box)
	get_tree().current_scene.add_child(box_left)

func _spawn_box_right():
	if box_right != null:
		await box_right.tree_exited
	box_right = box_node.instantiate()
	box_right.position = start_pos_right
	box_right.call_deferred("set_name", "BoxRight")
	box_right.next_box.connect(_on_next_box)
	get_tree().current_scene.add_child(box_right)

func _on_next_box():
	if not box_left:
		_spawn_box_left()
	if not box_right:
		_spawn_box_right()
