extends Sprite2D

class_name Unit

var hp : int = 100
var agility : int = 1


### IM NOT TOO SURE WHAT THESE _READY AND _PROCESS DO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func take_damage(damage: int) -> void:
	hp -= damage

func set_hp(new_hp: int) -> void:
	hp = new_hp
	
func set_agility(new_agility: int) -> void:
	agility = new_agility
	
# moves unit to destination. Assumes the destination is valid based on agility/pos from TurnManager?
func move_to_tile(destination: Vector2) -> void:
	# no animation, unit is 'teleporting'; Vector2(64, 32) is just a placeholder for a tilesize
	position = destination * Vector2(64, 32)


# getter methods

# converting pixel coordinate system to grid coord, CHANGE TILE_SIZE
func get_curent_tile() -> Vector2:
	var tile_size : Vector2 = Vector2(64, 32)
	var grid_position : Vector2 = position / tile_size
	return Vector2(floor(grid_position.x), floor(grid_position.y))
	
func get_hp() -> int:
	return hp
func get_agility() -> int:
	return agility
