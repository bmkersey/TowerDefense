extends PathFollow3D

@export var maxHP:= 50
@export var speed:float = 2.5
var currentHP: int:
	set(health_in):
		if health_in < currentHP:
			animationPlayer.play('TakeDamage')
		currentHP = health_in
		if currentHP < 1:
			queue_free()

@onready var base = get_tree().get_first_node_in_group("base")
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	currentHP = maxHP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)
