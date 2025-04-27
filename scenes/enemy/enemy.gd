extends StaticBody3D

var lives = 3
var is_killed = false

@onready var label = $Label3D
@onready var hitbox = $HitBox
@onready var explosion = $Explosion
@onready var body = $Body


func _ready():
	explosion.emitting = false


func _on_hit_box_area_entered(area: Area3D) -> void:
	if is_killed:
		return

	lives -= 1
	label.text = "lives: " + str(lives)

	if lives <= 0:
		is_killed = true
		hitbox.set_deferred("monitoring", false)
		body.hide()
		label.hide()
		explosion.emitting = true


func _on_explosion_finished() -> void:
	get_parent().remove_child(self)
	queue_free()
