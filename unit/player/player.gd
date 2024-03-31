class_name Player extends Unit

@onready var healthBar: HealthBarHud = $HUD/HealthBarHUD

var hasAttacked: bool = false
var hasMoved: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	maxHp = 10
	hp = 10
	healthBar.set_health_bar_max_health(maxHp)
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthBar.set_health_bar_value(hp)
	
	if isTakingTurn:
		if !hasAttacked && hasMoved && curr_path.is_empty():
			hasAttacked = true
			isTakingTurn = false
	else:
		hasAttacked = false
		hasMoved = false

	
	
func _input(event):
	super(event)
	if event.is_action_pressed("click"):
		hasMoved = true
		isTakingTurn = false
