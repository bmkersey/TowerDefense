extends Node3D

@export var projectile: PackedScene
@export var towerRange := 10.0
var enemyPath: Path3D
var target: PathFollow3D
@onready var barrel := $TowerBase/CenterBarrel
@onready var animationPlayer := $AnimationPlayer

func shoot() -> void:
	var shot = projectile.instantiate()
	add_child(shot)
	shot.global_position = barrel.global_position
	shot.direction = global_transform.basis.z
	animationPlayer.play("fire")


func find_best_target() -> PathFollow3D:
	var bestTarget = null
	var bestProgress = 0
	for enemy in enemyPath.get_children():
		if enemy is PathFollow3D:
			var enemyDistance = global_position.distance_to(enemy.global_position)
			if enemyDistance < towerRange:
				if enemy.progress > bestProgress:
					bestTarget = enemy
					bestProgress = enemy.progress
	return bestTarget

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if target:
		shoot()
