extends Node
func _ready():
	DiscordRPC.app_id = 1099618430065324082 # Application ID
	DiscordRPC.details = "A demo activity by vaporvee"
	DiscordRPC.state = "Checkpoint 23/23"
	DiscordRPC.large_image = "example_game" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "Try it now!"
	DiscordRPC.small_image = "boss" # Image key from "Art Assets"
	DiscordRPC.small_image_text = "Fighting the end boss! D:"
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	DiscordRPC.refresh() # Always refresh after changing the values!
