extends RigidBody3D

@export var speed = 20.0
@export var lifetime = 5.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D

var velocity = Vector3.ZERO

func _ready():
	velocity = transform.basis.z.normalized() * speed
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _process(delta):
	linear_velocity = velocity
	if ray.is_colliding():
		if (ray.get_collider().is_in_group("enemies")):
			print("enemy")
		else:
			print("indestructible")
		mesh.visible = false
		particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free()


func _on_timer_timeout():
	queue_free()
