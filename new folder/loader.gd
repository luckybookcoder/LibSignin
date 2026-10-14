extends Control
@onready var oldfocus:Node= $"/root/main/ID"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var setbackfocus = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().process_frame
	if $"..".loading:
		show()
		grab_focus()
		setbackfocus = true
		$Sprite2D.rotation_degrees += 1
	else:
		$Sprite2D.rotation = 0
		if setbackfocus:
			setbackfocus = false
			oldfocus.grab_focus()
		hide()
		oldfocus = get_viewport().gui_get_focus_owner()
