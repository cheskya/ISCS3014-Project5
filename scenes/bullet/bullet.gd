extends CharacterBody3D

@export var speed = 50.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var explosion = $Explosion
@onready var life_timer = $LifeTimer

var collision_point
var direction
var is_moving = false
	

func _physics_process(delta):
	if is_moving:
		move_and_slide()
	if ray.is_colliding():
		explosion.emitting = true
		ray.enabled = false
		mesh.hide()


func start():
	ray.target_position = ray.target_position * 0.5
	velocity = direction * speed
	life_timer.start()
	is_moving = true


func _on_life_timer_timeout():
	queue_free()


func _on_explosion_finished():
	queue_free()
