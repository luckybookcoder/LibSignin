extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(register) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func register():
	$"../ID".call("register",$id.text,$Name.text)
	$id.text = ''
	$Name.text = ''
