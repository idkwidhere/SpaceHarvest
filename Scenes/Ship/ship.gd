extends StaticBody3D

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
	
func _process(delta: float) -> void:
	pass
	
func _send_inventory() -> void:
	print("fired")
	print(seed_inventory)
