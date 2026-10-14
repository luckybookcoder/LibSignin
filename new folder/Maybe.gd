extends Node2D
const WEB_APP_URL = "https://script.google.com/macros/s/AKfycbwFBEi1RhVwpOaFkKlVnfZaXHNcMDDHoYdwfN0-1WRe-DN_PZ_LXZqAm1gl66Y4KZ8HtA/exec"
var loading

@onready var http_request = $HTTPRequest


func _ready() -> void:
	http_request.request_completed.connect(_on_request_completed)

func send_data_to_sheet(payload:Dictionary) -> void:
	var json_string = JSON.stringify(payload)
	var headers = ["Content-Type: text/plain"]
	
	var err = http_request.request(WEB_APP_URL, headers, HTTPClient.METHOD_POST, json_string)
	if err:
		$"/root/main/Log".text += "\n" + str("Error sending request for Send_Login_Data! Error code ", err)
	else:
		loading = true

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		$"/root/main/Log".text += "\n" + str("Login Data sent successfully: ", body.get_string_from_utf8())
	else:
		$"/root/main/Log".text += "\n" + str("Send_Login_Data failed with response code: ", response_code)
	loading = false
