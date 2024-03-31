extends CharacterBody2D

class_name Unit

var maxHp : int = 100
var hp : int = 100
var agility : int = 1
var attackDamage: int = 1

var isTakingTurn: bool = false

@export var speed = 700
@onready var tile_map = $"../TileMap"
#var target = position
var astar: AStarGrid2D
var curr_path: Array[Vector2i]

### IM NOT TOO SURE WHAT THESE _READY AND _PROCESS DO

# Called when the node enters the scene tree for the first time.
func _ready():
	astar = AStarGrid2D.new()
	astar.region = tile_map.get_used_rect()
	astar.cell_size = Vector2(16,16)
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	astar.update()
	
	for x in tile_map.get_used_rect().size.x:
		for y in tile_map.get_used_rect().size.y: 
			var tile_pos = Vector2i(
				x + tile_map.get_used_rect().position.x, 
				y + tile_map.get_used_rect().position.y
			)
			
			var data = tile_map.get_cell_tile_data(0, tile_pos)
			if data == null or data.get_custom_data("Walk") == true:
				astar.set_point_solid(tile_pos)
				
	
			# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func take_damage(damage: int) -> void:
	hp -= damage

func set_hp(new_hp: int) -> void:
	hp = new_hp
	
func set_agility(new_agility: int) -> void:
	agility = new_agility
	
# getter methods
func get_hp() -> int:
	return hp
func get_agility() -> int:
	return agility
	
	
# moves unit to destination. Assumes the destination is valid based on agility/pos from TurnManager?
func move_to_destination(destination: Vector2) -> void:
	var id_path = astar.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(destination)
	).slice(1)
	
	
	print(id_path)
	if id_path.is_empty() == false:
		curr_path = id_path

# converting pixel coordinate system to grid coord, CHANGE TILE_SIZE
func get_curent_tile() -> Vector2:
	var tile_size : Vector2 = Vector2(64, 32)
	var grid_position : Vector2 = position / tile_size
	return Vector2(floor(grid_position.x), floor(grid_position.y))
	
	
	
# free movement
func _input(event):
	if isTakingTurn:
		if event.is_action_pressed("click") == false:
			return
		var id_path = astar.get_id_path(
			tile_map.local_to_map(global_position),
			tile_map.local_to_map(get_global_mouse_position())
		).slice(1)
		
		
		print(id_path)
		if id_path.is_empty() == false:
			curr_path = id_path
		
	#target = get_global_mouse_position()
func _physics_process(delta):
	if curr_path.is_empty():
		return
	var target_pos = tile_map.map_to_local(curr_path.front())
	global_position = global_position.move_toward(target_pos, 1)
	
	if global_position == target_pos:
		curr_path.pop_front()
	
