extends Node2D
class_name EnemyHandler

static var next_enemy_id_n: int = 0
static var active_enemy_ids: Array[String]
static var id_to_enemy: Dictionary = {}

static var enemies_node: Node


func _ready():
	enemies_node = get_tree().get_root().get_node("test_level").get_node("Enemies")


static func create_enemy(level: int, place: int) -> Node:
	var id: String = str(next_enemy_id_n)
	var enemy: Node = Enemy.create(level, id)
	
	id_to_enemy[id] = enemy
	active_enemy_ids[place] = id
	
	next_enemy_id_n += 1
	enemies_node.add_child(enemy)
	return enemy


static func get_enemy_from_index(index: int) -> Node:
	if index == -1:
		return null
	else:
		return id_to_enemy[active_enemy_ids[index]]


static func get_furthest_enemy_index(start: int = 0) -> int:
	for i: int in range(start, active_enemy_ids.size()):
		var enemy_id: String = active_enemy_ids[i]
		if enemy_id != "":
			return i
	
	return -1


static func register_enemy_death(id: String) -> void:
	id_to_enemy[id] = null
	var index: int = active_enemy_ids.find(id)
	if (index != -1):
		active_enemy_ids[index] = ""


static func register_enemy_finished_path(id: String) -> void:
	Globals.take_damage()


static func on_new_round(enemy_count: int) -> void:
	for enemy_id: String in active_enemy_ids:
		id_to_enemy[enemy_id] = null
	
	active_enemy_ids = []
	active_enemy_ids.resize(enemy_count)
