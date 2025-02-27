extends StaticBody3D

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
	SignalBus.connect("send_ship_inventory", send_inventory)
	
func _process(delta: float) -> void:
	pass
	
func send_inventory() -> Dictionary :
	return seed_inventory
