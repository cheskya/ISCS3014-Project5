extends Area3D

@export var speed = 50.0
@export var collisions = 0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@onready var particles = $GPUParticles3D
@onready var life_timer = $LifeTimer
@onready var explosion_timer = $ExplosionTimer

var direction
var is_moving = false


func _ready():
	life_timer.start()
	

func _physics_process(delta):
	if is_moving:
		position += direction * speed * delta


func start():
	is_moving = true


func _on_life_timer_timeout():
	get_parent().remove_child(self)
	queue_free()


func _on_explosion_timer_timeout():
	get_parent().remove_child(self)
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	#mesh.visible = false
	print(area)
	particles.emitting = true
	explosion_timer.start()
	get_parent().remove_child(self)
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	print(body)
	particles.emitting = true
	explosion_timer.start()
