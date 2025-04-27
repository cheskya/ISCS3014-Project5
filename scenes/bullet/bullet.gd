extends Area3D

@export var speed = 5.0
@export var lifetime = 5.0

var move_direction = Vector3.FORWARD
var collided = false

@onready var mesh_instance = $MeshInstance3D

func _ready():
	await get_tree().create_timer(lifetime).timeout
	if not collided:
		queue_free()

func _physics_process(delta):
	if not collided:
		global_translate(move_direction * speed * delta)

func _on_body_entered(body: Node):
	if collided:
		return
	collided = true
	mesh_instance.visible = false
	$GPUParticles3D.emitting = true
	
	if body.is_in_group("enemies"):
		print("hit enemy")
	elif body.is_in_group("indestructibles"):
		print("hit indestructible")
	else:
		print("hit something else")
	await get_tree().create_timer(0.2).timeout
	queue_free()

func set_direction(dir: Vector3):
	move_direction = dir.normalized()
