class_name Enemy extends Unit

@export var texture: Texture2D

var hasAttacked: bool = false
var hasMoved: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = texture
	super()
	isTakingTurn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isTakingTurn:
		if !hasMoved:
			move_to_destination(get_nearest_player().position)
			hasMoved = true
		if !hasAttacked && hasMoved && curr_path.is_empty():
			attack(attackDamage, get_nearest_player())
			hasAttacked = true
			isTakingTurn = false
	else:
		hasMoved = false
		hasAttacked = false
	pass
	
func _input(event):
	pass
	
func move_towards_player_then_attack():
	var player = move_towards_nearest_player()
	attack(attackDamage, player)
	
	
func get_nearest_player():
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 1:
		return players.reduce(func(max, val): return val if is_distance_to_greater(val, max) else max)
		
	return players[0]
	
func move_towards_nearest_player():
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 1:
		players = players.reduce(func(max, val): return val if is_distance_to_greater(val, max) else max)
		
	print_debug(players)
	
	var nearest_player = players[0]
	
	move_to_destination(nearest_player.position)
		
	return nearest_player
	
	
func attack(damageValue: int, player: Player):

#TODO: add check if player is in attack range
	player.take_damage(damageValue)

func is_distance_to_greater(a, b):
	return a.global_position.distance_to(self.global_position) > b.global_position.distance_to(self.global_position)

	


