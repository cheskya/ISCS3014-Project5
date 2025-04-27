extends StaticBody3D

var lives = 3
var has_exploded = false
signal enemy_killed(enemy)

@onready var label = $Label3D
@onready var hitbox = $HitBox
@onready var explosion = $GPUParticles3D
@onready var explosion_timer = $ExplosionTimer
@onready var body = $Body

func _ready():
	explosion.emitting = false

func _on_hit_box_area_entered(area: Area3D) -> void:
	if has_exploded:
		return

	lives -= 1
	label.text = "lives: " + str(lives)

	if lives <= 0:
		has_exploded = true
		hitbox.set_deferred("monitoring", false)
		explode()


func explode():
	body.hide()
	label.hide()
	explosion.emitting = true
	explosion_timer.start()


func _on_explosion_timer_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()
