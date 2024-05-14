extends Node3D

@export var max_hp: int = 5
var current_health: int :
	set(health):
		current_health = health
		label_3d.text = str(current_health) + "/" + str(max_hp)
		var green = Color.LIME
		var red = Color.RED
		label_3d.modulate = red.lerp(green, float(current_health)/float(max_hp))
		print("Health was changed")
		if current_health < 1:
			get_tree().reload_current_scene()

@onready var label_3d: Label3D = $Label3D

func _ready() -> void:
	current_health = max_hp

func take_damage() -> void:
	print('Ow...dont do that!')
	current_health -= 1
