extends Node3D

# ship stuff
var gravity = true
var water = 100.0
var oxygen = 100.0
var credit = 500.0




var seed_inventory: Dictionary = {
	"carrot": {
		"seeds": 5,
		"crops": 0
	},
	
	"onion": {
		"seeds": 5,
		"cropts": 0
	},
	
	"potatoes": {
		"seeds": 5,
		"crops": 0
	},
	
}






func _ready() -> void:
	SignalBus.connect("send_ship_inventory", _send_inventory)
	SignalBus.connect("subtract_seed", subtract_seed)
	
func _process(delta: float) -> void:
	pass
	
func _send_inventory() -> void:
	print("_send_inventory fired")
	SignalBus.emit_signal("ship_inventory_dictionary", seed_inventory)

func subtract_seed(seed_name) -> void:
	print(seed_name)
