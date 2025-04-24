extends CSGCylinder3D

var lives = 3
var has_exploded = false
signal enemy_killed(enemy)

@onready var label = $Label3D
@onready var hitbox = $HitBox

var ExplosionScene = preload("res://scenes/explosion.tscn")

func _on_hit_box_body_entered(body: Node3D) -> void:
	if has_exploded:
		return

	lives -= 1
	label.text = "lives: " + str(lives)

	if lives <= 0:
		has_exploded = true
		hitbox.set_deferred("monitoring", false)

		var explosion = ExplosionScene.instantiate()
		get_parent().add_child(explosion)
		explosion.global_position = global_position
		explosion.emitting = true

		await get_tree().create_timer(0.05).timeout
		explosion.emitting = false

		enemy_killed.emit(self)
		queue_free()
