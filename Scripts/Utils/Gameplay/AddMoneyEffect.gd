extends EffectPlayer


export (int) var money: int
var money_manager: MoneyManager = null

export (NodePath) var pos_path: NodePath
onready var pos = get_node(pos_path)



func _ready():
	var manager: MoneyManager = get_tree().get_nodes_in_group(MoneyManager.group)[0]
	money_manager = manager



func play_effect():
	money_manager.add_money(money, pos.global_position)
