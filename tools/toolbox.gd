extends Node

@onready var equipped_tool: Node = $Blank #Blank is a placeholder for when no tool is being used
var mouse_pos: Vector2 = Vector2.ZERO

#When complete, should be sc,fo,gel, syringe, sutures, drain, ls, ultrasound
@onready var wheel_array = [$Scalpel, $Forceps, $Gel, $Blank, $Sutures, $Blank, $Laser, $Blank]
var other_tools = []

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			equipped_tool.move(event.position)
			equipped_tool.click()
		else:
			equipped_tool.release()
	
	if event is InputEventMouseMotion:
		mouse_pos = event.position
		equipped_tool.move(mouse_pos)
	
	if (event.is_action_pressed("tool_wheel_down") or event.is_action_pressed("tool_wheel_up")
	or event.is_action_pressed("tool_wheel_right") or event.is_action_pressed("tool_wheel_left")):
		check_tool_wheel()

func equip(tool: Node):
	if equipped_tool != tool:
		equipped_tool.unequip()
		equipped_tool = tool
		equipped_tool.move(mouse_pos)
		
		$ToolSwitchSound.play()

func check_tool_wheel():
	var direction = Input.get_vector("tool_wheel_left", "tool_wheel_right", "tool_wheel_up", "tool_wheel_down")
	if direction == Vector2.ZERO: return
	var angle = direction.angle()
	angle += PI * 9/8
	if angle > 2*PI: angle -= 2*PI
	angle *= 4/PI
	var index = int(angle)
	equip(wheel_array[index])
	$ToolWheel.set_equipped(index)

func reset_tools():
	for i in wheel_array:
		i.reset()
	for i in other_tools:
		i.reset()

func equip_extra_tool(tool: Node):
	equip(tool)
	if tool not in other_tools: other_tools.append(tool)
	$ToolWheel.unequip()
