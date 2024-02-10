extends Control

@onready var statusContainer = $VBoxContainer2/HFlowContainer

# Import character status effects using an @export variable for a CharacterStatuses class or something

# For this class we will just be displaying whatever is held in the array of status effects linked to a player/character
# We should consider creating a Status Effect type object with a description so that we can also display tooltips properly

# Eventually, whenever a character gets a new status effect, update this using a signal or something
# Character status updates, sends signal -> ui gets signal -> ui responds by updating from character status array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateStatusEffects():
	#activated by signal to populate HFlowContainer each time a the character effects change
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
