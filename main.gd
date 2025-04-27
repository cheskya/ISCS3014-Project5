extends Node3D

@onready var enemyGroup = $Enemies
var enemyList


func _ready() -> void:
	enemyList = get_tree().get_nodes_in_group("enemies")
	print(enemyList)
	for enemy in enemyList:
			enemy.enemy_killed.connect(_on_enemy_killed)


func _process(delta: float) -> void:
	pass


func _on_enemy_killed(enemy) -> void:
	enemyGroup.remove_child(enemy)
