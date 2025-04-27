extends CharacterBody3D

var lives = 3
var is_killed = false

@onready var label = $Label3D
@onready var hitbox = $HitBox
@onready var explosion = $Explosion
@onready var mesh = $Mesh


func _on_hit_box_body_entered(body: Node3D) -> void:
	if is_killed:
		return
	
	if body.is_in_group("bullet"):
		lives -= 1
		label.text = "lives: " + str(lives)

		if lives <= 0:
			is_killed = true
			hitbox.set("monitoring", false)
			mesh.hide()
			label.hide()
			explosion.emitting = true


func _on_explosion_finished() -> void:
	queue_free()
