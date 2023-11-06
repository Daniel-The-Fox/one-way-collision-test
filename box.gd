extends CharacterBody2D

var speed = 300

signal next_box

func _ready():
	velocity = speed * Vector2.DOWN
	print("speed: " + str(speed))
	print("velocity: " + str(velocity))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		print("collider: " + str(collision.get_collider()))

func _on_screen_exited() -> void:
	print(self.name + " exited screen")
	next_box.emit()
	queue_free()
