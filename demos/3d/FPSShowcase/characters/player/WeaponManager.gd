extends Spatial

enum WEAPON_SLOTS {
	MACHETE,
	MACHINE_GUN,
	SHOTGUN,
	ROCKET_LAUNCHER
}

var slots_unlocked = {
	WEAPON_SLOTS.MACHETE: true,
	WEAPON_SLOTS.MACHINE_GUN: true,
	WEAPON_SLOTS.SHOTGUN: true,
	WEAPON_SLOTS.ROCKET_LAUNCHER: true
}

onready var weapons = $Weapons.get_children()
var current_slot = 0
var current_weapon = null

func _ready():
	pass


func switch_to_next_weapon():
	current_slot = (current_slot + 1) % slots_unlocked.size()
	if !slots_unlocked[current_slot]:
		switch_to_next_weapon()
	else:
		switch_to_weapon_slot(current_slot)

func switch_to_last_weapon():
	current_slot = posmod((current_slot - 1), slots_unlocked.size())
	if !slots_unlocked[current_slot]:
		switch_to_last_weapon()
	else:
		switch_to_weapon_slot(current_slot)

func switch_to_weapon_slot(slot_ind: int):
	if slot_ind < 0 or slot_ind >= slots_unlocked.size():
		return
	
	if !slots_unlocked[current_slot]:
		return
	
	disable_all_weapons()
	current_weapon = weapons[slot_ind]
	if current_weapon.has_method("set_active"):
		current_weapon.set_active()
	else:
		current_weapon.show()

func disable_all_weapons():
	for weapon in weapons:
		if weapon.has_method("set_inactive"):
			weapon.set_inactive()
		else:
			weapon.hide()

func attack():
	for weapon in weapons:
		weapon.get_node("AnimationPlayer").play("Attack")
