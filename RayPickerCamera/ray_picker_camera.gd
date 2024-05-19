extends Camera3D

@export var gridMap: GridMap
@export var towerManager: Node3D
@onready var rayCast: RayCast3D = $RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mousePos: Vector2 = get_viewport().get_mouse_position()
	rayCast.target_position = project_local_ray_normal(mousePos) * 100.0
	rayCast.force_raycast_update()

	if rayCast.is_colliding():
		var collider = rayCast.get_collider()
		if collider is GridMap:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			if Input.is_action_just_pressed("click"):
				var collisionPoint = rayCast.get_collision_point()
				var cell = gridMap.local_to_map(collisionPoint)
				if gridMap.get_cell_item(cell) == 0:
					gridMap.set_cell_item(cell, 1)
					var tilePosition = gridMap.map_to_local(cell)
					towerManager.build_tower(tilePosition)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
