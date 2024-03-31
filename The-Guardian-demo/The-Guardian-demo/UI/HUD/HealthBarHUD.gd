extends Control

class_name HealthBarHud

@onready var healthBarLabel = $Label
@onready var healthBar = $ProgressBar

var health = 100;


# Called when the node enters the scene tree for the first time.
func _ready():
#	ready_test()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	process_test()
	pass
	
# Test functions below, can remove later. 
#=========================================================================
# Called when the node enters the scene tree for the first time.
func ready_test():
	set_health_bar_max_health(100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_test():
	health-=1
	set_health_bar_value(health)
	if (health<0): health = 100
#=========================================================================

#Update the functions below from the Unit every time a player takes damage
func set_health_bar_max_health(max_health: int):
	healthBar.max_value = max_health

func set_health_bar_value(health_value: int) -> void:
	healthBarLabel.text = "HEALTH: %s" % health_value
	healthBar.value = health_value

