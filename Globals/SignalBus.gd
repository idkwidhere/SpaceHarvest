extends Node

signal growth_done

# menus
signal toggle_player_menu
signal toggle_main_menu
signal show_interact_prompt


#inventory
signal send_ship_inventory
signal ship_inventory_dictionary(inventory)

# inventory add/remove
signal subtract_seed(seed_name)
