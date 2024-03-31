extends TileMap

class_name IsometricTileMap


const TILESIZE : int = 64

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Dictionary to keep track of which units are on which tiles
# key: Vector2 tile, value Unit
var units_on_tiles = {}  

# Method to add a unit to a specific tile
# tile should be in tile based coordinates rather than pixel/ world coords??
func add_unit_to_tile(unit: Unit, tile: Vector2) -> void:
	units_on_tiles[tile] = unit
	unit.position = tile_to_world_position(tile)

# moves unit to new_tile, 
func move_unit_to_tile(unit: Unit, new_tile: Vector2) -> void:
	var current_tile = world_to_tile_position(unit.position)
	if units_on_tiles.has(current_tile):
		# DO SOMETHING IF TILE HAS ANOTHER UNIT ON IT IDK
		return
	units_on_tiles[new_tile] = unit 
	unit.position = tile_to_world_position(new_tile)

# returns the unit on the given tile, null otherwise
func get_unit_from_tile(tile: Vector2) -> Unit:
	return units_on_tiles.get(tile, null) 

# returns true if there are no units on the tile
func is_tile_free(tile: Vector2) -> bool:
	return units_on_tiles.values().find(tile, 0) == -1

# Utility method for tile -> world coords
func tile_to_world_position(tile: Vector2) -> Vector2:
	return tile * TILESIZE

# Utility method for world -> tile coords
func world_to_tile_position(world_position: Vector2) -> Vector2:
	return world_position / TILESIZE

# returns all units on the coords from given tiles.
# Only includes those that are occupied
func get_units_on_tiles(tiles: PackedVector2Array) -> Array:
	var units = []
	for tile in tiles:
		if units_on_tiles.has(tile):
			units.append(units_on_tiles[tile])
	return units
