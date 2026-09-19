extends LineEdit
var IDicts :Dictionary= {774937:"The Lucky Bookwyrm"}
enum reasons {for_an_unstated_reason,to_check_out_or_return_materials,for_lunch,as_a_hangout_spot,to_print_something,for_a_club_meeting,to_study,for_a_custom_reason00,}
const compreason = ["Unstated","Checkout/Return","Lunch","Hang out",'$"/root/main/Log".text += "\n" + string',"Club","Study",'']
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_data() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		grab_data()

func _on_text_submitted(new_text: String) -> void:
	var time = Time.get_datetime_dict_from_system(false)
	var reason = 0
	for i in $"../WhyLine".get_children():
		if i.on:
			reason = int(i.name.replace("Button",''))
	if reason == compreason.size():
		assert($"../WhyLine/Button7/LineEdit".text != "", "
ERR:
Please don't enter an empty explanation. You don't have to select a reason :)")
	var _cust = ""
	reason = reasons.find_key(reason)
	#$"/root/main/Log".text += "\n" + str(IDicts[(new_text)]," visited the library ", str(reason).replace("_"," ").replace("00",':'), " on ",["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][time.weekday],", ","0" if time.month<10 else"",time.month, "/",time.day,"/",time.year,", at ",time.hour,":",time.minute,"::",time.second)
	var gimme = ({who=IDicts[(new_text)],why=str(compreason[reasons[reason]] if reason else '',),"when"=str(["Su","M","Tu","W","Th","F","Sa"][time.weekday]," ","0" if time.month<10 else"",time.month, "/","0" if time.day<10 else"",time.day,"/",time.year," ","0" if time.hour<10 else"",time.hour,":","0" if time.minute<10 else"",time.minute,"::","0" if time.second<10 else"",time.second)})
	assert((int(new_text) < 1e6 && int(new_text) >= 1e5), "
ERR:
Invalid Student ID")
	
	#$"/root/main/Log".text += "\n" + str(gimme)
	$"..".send_data_to_sheet(gimme)

@onready
var http_request = $HTTPRequest
const WEB_APP_URL = "https://script.google.com/macros/s/AKfycbyu2uL_HX1_v_R5Z3EHQhg5Ze386jje-hBUleY44cCC22lt9ByelsA2ijv_e7RgeGmC/exec"
func grab_data():
	var headers = ["Content-Type: text/plain"]
	
	var err = http_request.request(WEB_APP_URL, headers, HTTPClient.METHOD_GET)
	if err != OK:
		$"/root/main/Log".text += "\n" + str("Error sending request for Grab_Data!")

func send_data():
	var headers = ["Content-Type: text/plain"]
	
	var err = http_request.request(WEB_APP_URL, headers, HTTPClient.METHOD_POST, JSON.stringify(IDicts))
	if err != OK:
		$"/root/main/Log".text += "\n" + str("Error sending request for Send_Data!")
	

@warning_ignore("unused_parameter")
func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	$"/root/main/Log".text += "\n" + str(result)
	$"/root/main/Log".text += "\n" + str("YAEY", response_code, "Oh wait awww" if response_code != 200 else ":)")
	$"/root/main/Log".text += "\n" + str(body.get_string_from_utf8()) # Replace with function body.
	$"/root/main/Log".text += "\n" + str(JSON.parse_string(body.get_string_from_utf8()))
	IDicts = JSON.parse_string(body.get_string_from_utf8())
