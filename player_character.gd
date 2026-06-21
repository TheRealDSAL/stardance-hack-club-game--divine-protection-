extends CharacterBody2D
@onready var visionbox = $Vision
@export var speed = 200
var closestenemy = null
var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemies = visionbox.get_overlapping_bodies()
	if enemies.size() == 0:
		closestenemy = null
		direction = randi_range(1,359)
	else:
		var closestenemy = null
		for enemy in enemies:
			if closestenemy == null:
				closestenemy = self
			elif enemy.global_position.distance_to(self) > closestenemy.global_position.distance_to(self):
				closestenemy = enemy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if closestenemy == null:
		global_rotation = direction
		var directionfacing = Vector2(cos(global_rotation), sin(global_rotation))
		velocity = directionfacing * speed
		move_and_slide()
		global_rotation = 0
