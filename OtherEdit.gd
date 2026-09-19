extends LineEdit
var stop = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $"..".on:
		if !stop:
			grab_focus()
			stop = true
	else:
		stop = false
	if has_focus():
		$"..".on = true
		for i in $"..".get_parent().get_children().filter(func onebutton(button):return "on" in button):
			if i != $"..":
				i.on = false
