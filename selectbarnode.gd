extends Button
var on = false

func _process(delta: float) -> void:
	var which = "normal_mirrored"
	if on:
		which = "pressed_mirrored"
	if button_pressed:
		which = "hover_mirrored"
	for i in ["normal","pressed","hover_pressed","hover",]:
		add_theme_stylebox_override(i,get_theme_stylebox(which))


func _on_pressed() -> void:
	on = !on # Replace with function body.
	if on:
		for i in get_parent().get_children().filter(func onebutton(button):return "on" in button):
			if i != self:
				i.on = false
