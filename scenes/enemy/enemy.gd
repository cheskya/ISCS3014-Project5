extends CSGCylinder3D

var lives = 3
signal enemy_killed(enemy)

@onready var label = $Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hit_box_body_entered(body: Node3D) -> void:
	lives -= 1
	label.text = "lives: " + str(lives)
	if (lives <= 0):
		enemy_killed.emit(self)
