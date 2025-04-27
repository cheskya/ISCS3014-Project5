extends RigidBody3D

@export var speed = 10.0
@export var lifetime = 5.0
@export var collisions = 0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

var player
var direction

func _physics_process(delta):
	position += player * speed * delta
	if ray.is_colliding():
		collisions += 1
		mesh.visible = false
		particles.emitting = true
		if (ray.get_collider().is_in_group("enemies")):
			print("enemy")
		else:
			print("indestructible")


func _on_timer_timeout():
	queue_free()
