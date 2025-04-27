extends RigidBody3D

@export var speed = 50.0
@export var collisions = 0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

var direction
var is_moving = false

func _physics_process(delta):
	if is_moving:
		position += direction * speed * delta
		if ray.is_colliding():
			collisions += 1
			get_parent().remove_child(self)
			queue_free()
			mesh.visible = false
			particles.emitting = true
			if (ray.get_collider().is_in_group("enemies")):
				print("enemy")
			else:
				print("indestructible")


func start():
	is_moving = true


func _on_timer_timeout():
	get_parent().remove_child(self)
	queue_free()
