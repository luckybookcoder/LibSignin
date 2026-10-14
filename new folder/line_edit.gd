extends LineEdit
var IDicts :Dictionary= {}
enum reasons {for_an_unstated_reason,to_check_out_or_return_materials=1,for_lunch,as_a_hangout_spot,to_print_something,for_a_club_meeting,to_study,for_a_custom_reason00,}
const compreason = ["Unstated","Checkout/Return","Lunch","Hang out",'print',"Club","Study",'']
const Leaderboard_URL = "https://script.google.com/macros/s/AKfycbwJ0ZLzXrIbJFMPO5Cr_C7fN-gKAVA12BytQVOGJFThH4o1M1leC0l4DL73JoTIM-f-sQ/exec"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ID:
		grab_data()
		grab_focus() # Replace with function body.
@export var ID = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#@warning_ignore("unused_parameter")
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_cancel") and ID:
		#print(IDicts.get_or_add(str(int(1e5+randi()%900000)),"Random new name"))
		#send_data()

func _on_text_submitted(new_text: String) -> void:
	var time = Time.get_datetime_dict_from_system(false)
	var reason = 0
	for i in $"../WhyLine".get_children():
		if i.on:
			reason = int(i.name.replace("Button",''))
	if reason == compreason.size():
		if $"../WhyLine/Button7/LineEdit".text == "":
			reason = 0
	if ID:
		assert(new_text.length() == 6 and new_text.is_valid_int(),"Invalid SSID. Contact me if you're sure you typed it correctly")
		assert(new_text in IDicts, 'Unregistered SSID. Just click "Register", and it\'s a really quick process to get set up')
	var _cust = ""
	reason = reasons.find_key(reason)
	print(reasons[reason], compreason.size())
	#$"/root/main/Log".text += "\n" + str(IDicts[(new_text)]," visited the library ", str(reason).replace("_"," ").replace("00",':'), " on ",["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][time.weekday],", ","0" if time.month<10 else"",time.month, "/",time.day,"/",time.year,", at ",time.hour,":",time.minute,"::",time.second)
	var gimme = ({who=(IDicts[new_text] if ID else new_text),why=str(compreason[reasons[reason]] if reason else '', $"../WhyLine/Button7/LineEdit".text if reasons[reason] == compreason.size()-1 else ''),"when"=str(["Su","M","Tu","W","Th","F","Sa"][time.weekday]," ","0" if time.month<10 else"",time.month, "/","0" if time.day<10 else"",time.day,"/",time.year," ","0" if ((time.hour-1)%12)<9 else"",((time.hour-1)%12)+1,":","0" if time.minute<10 else"",time.minute,"AM" if time.hour<12 else "PM", )})
	#assert((int(new_text) < 1e6 && int(new_text) >= 1e5), "
#ERR:
#Invalid Student ID")
	
	#$"/root/main/Log".text += "\n" + str(gimme)
	$"..".send_data_to_sheet(gimme)
	leaderboard(IDicts[new_text] if ID else new_text)
	text = ''
@onready
var http2 = $HTTPRequest2 

func leaderboard(who:String):
	var headers = ["Content-Type: text/plain"]
	print(who)
	var err = http2.request(Leaderboard_URL, headers, HTTPClient.METHOD_POST, JSON.stringify(who))
	if err:
		$"/root/main/Log".text += "\n" + str("Error sending request to the leaderboard! Error code ", err)
	else:
		$'..'.loading = true
	

@onready
var http_request = $HTTPRequest
const WEB_APP_URL = "https://script.google.com/macros/s/AKfycbwZri--WthxqrIFwgF_5nbyPdcZ_7rh54QMlxrEJ_4F1et0gNn2LXC75vo9vK2hGK58/exec"
func grab_data():
	var headers = ["Content-Type: text/plain"]
	
	var err = http_request.request(WEB_APP_URL, headers, HTTPClient.METHOD_GET)
	if err:
		$"/root/main/Log".text += "\n" + str("Error sending request for Grab_Data! Error code ", err)
	else:
		$"..".loading = true
	

func send_data():
	var headers = ["Content-Type: text/plain"]
	print(JSON.stringify(IDicts))
	var err = http_request.request(WEB_APP_URL, headers, HTTPClient.METHOD_POST, JSON.stringify(IDicts))
	if err:
		$"/root/main/Log".text += "\n" + str("Error sending request for Send_Data! Error code ", err)
	else:
		$'..'.loading = true
	

@warning_ignore("unused_parameter")
func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	$"/root/main/Log".text += "\n" + str(result)
	$"/root/main/Log".text += "\n" + str("YAEY", response_code, "Oh wait awww" if response_code != 200 else ":)")
	if JSON.parse_string(body.get_string_from_utf8()) != null:
		$"/root/main/Log".text += "\n" + str(body.get_string_from_utf8()) # Replace with function body.
		$"/root/main/Log".text += "\n" + str(JSON.parse_string(body.get_string_from_utf8()))
		IDicts = JSON.parse_string(JSON.parse_string(body.get_string_from_utf8()))
	$'..'.loading = false


func _on_http_request_2_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print(response_code,) # Replace with function body.
	$'..'.loading = false

func register(id:String,Name:String):
	assert(id.length() == 6 and id.is_valid_int(),"Invalid SSID. Contact me if you're sure you typed it correctly")
	IDicts.get_or_add(id,Name)
	send_data()
