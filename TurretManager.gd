extends Node3D
@export var turret: PackedScene
@export var enemyPath: Path3D

func build_tower(position: Vector3) -> void:
	var newTower = turret.instantiate()
	add_child(newTower)
	newTower.global_position = position
	newTower.enemyPath = enemyPath
