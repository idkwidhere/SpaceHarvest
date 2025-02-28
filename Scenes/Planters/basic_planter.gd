extends Interactable

var plant = preload("res://Scenes/Growables/Carrot/carrot_p1.tscn")

@onready var plant_start: Marker3D = $PlantStart
@onready var planter_light: OmniLight3D = $PlanterLight
@onready var planter_menu: Control = $PlanterMenu
@onready var plantable_seeds: VBoxContainer = $PlanterMenu/Panel/PlantableSeeds

# growing stuff
var is_full = false
var is_harvestable = false
var current_plant 

var plantables: Dictionary = {}


func _ready() -> void:
	SignalBus.growth_done.connect(plant_harvest)
	SignalBus.ship_inventory_dictionary.connect(_load_inventory)
	

func _process(delta: float) -> void:
	pass

func _on_interacted(body: Variant) -> void:
	print("Interacted with " + body.name)
	
	if body is Player and !is_full:
		plant_menu()
		is_full = true
		
	
	if body is Player and is_harvestable:
		is_full = false
		is_harvestable = false
		planter_light.hide()
		prompt_message = "Interact"
		
		# remove the finished plant
		for i in plant_start.get_children():
			i.queue_free()
			print(i)

func plant_seed():
	
	var instance = plant.instantiate()
	instance.position = plant_start.position
	plant_start.add_child(instance)

	
	

func plant_harvest():
	is_harvestable = true
	prompt_message = "Harvest"
	
func plant_menu():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	SignalBus.emit_signal("send_ship_inventory")
	planter_menu.show()
	
	
func _load_inventory(inventory):
	for i in inventory:
		var new_button = Button.new()
		new_button.text = i
		plantable_seeds.add_child(new_button)



func _on_plant_pressed() -> void:
	plant_seed()
	planter_light.show()
	planter_menu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_destroy_pressed() -> void:
	if is_full and !is_harvestable:
		for i in plant_start.get_children():
				i.queue_free()
				print(i)
		is_full = false
