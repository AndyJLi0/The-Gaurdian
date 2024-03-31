extends Node

@onready var turnQueue: Array[Unit] = []
@onready var turnQueueHUD: = $CanvasLayer/HFlowContainer

var activeUnit: Unit

# Called when the node enters the scene tree for the first time.
func _ready():
	var units = get_tree().get_nodes_in_group("unit")
	var playerUnits = get_tree().get_nodes_in_group("player")
	#todo: sort by agility
	print_debug(units)
	print_debug(playerUnits)
	turnQueue.append_array(units)

#	initialize activeUnit
	activeUnit = units[0]
	activeUnit.isTakingTurn = true
	print_debug(activeUnit)
	
	update_hud()
	
	
	
func update_hud():
#	initialize hflowcontainer hud
	for node in turnQueueHUD.get_children():
		node.queue_free()
		
	for unit in turnQueue:
		var unitTexture = TextureRect.new()
		unitTexture = unit.get_node("Sprite2D")
		turnQueueHUD.add_child(unitTexture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#check the turn status of the current unit, if done, cycle the unit to the back of the queue
	if !activeUnit.isTakingTurn:
		print_debug("advance unit turn")
		advance_turn()
		update_hud()

	
func advance_turn():
	turnQueue.push_back(turnQueue.pop_front())
	turnQueue[0].isTakingTurn = true;
	activeUnit = turnQueue[0]
	print_debug(activeUnit)
