extends Node

func load_monster(json_path: String, monster: Monster) -> Monster:
	var file = FileAccess.open(json_path, FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var json_parser = JSON.new()
		var error = json_parser.parse(json_text)  # Returns an error code (int)
		
		if error == OK:
			var monster_data = json_parser.get_data()
			
			# Basic information
			monster.monster_name = monster_data.get("monster_name", "Unnamed Monster")
			
			monster.cr = monster_data.get("cr", 0)
			monster.xp = monster_data.get("xp", 0)
			monster.present_xp = monster_data.get("present_xp", 0)
			monster.required_xp = monster_data.get("required_xp", 0)
			
			monster.race = Monster.Race.get(monster_data.get("race", "None"))
			monster.character_class = Monster.Character_Class.get(monster_data.get("character_class", "None"))
			monster.lvl = monster_data.get("lvl", 1)
			
			monster.alignment = Monster.Alignment.get(monster_data.get("alignment", "Neutral"))
			monster.creature_size = Monster.Creature_Size.get(monster_data.get("creature_size", "Medium"))
			monster.creature_type = Monster.Creature_Type.get(monster_data.get("creature_type", "Humanoid"))
			
			monster.init_mod=monster_data.get("init_mod",0)
			monster.normal_vision_range = monster_data.get("normal_vision_range", 250)
			# Senses and Auras
			monster.senses = monster_data.get("senses", {})
			monster.auras = monster_data.get("auras", {})
			monster.active_auras = monster_data.get("active_auras", {})
			monster.scent_strength = Monster.Scent.get(monster_data.get("scent_strength", "normal"))
			
			# Defense
			monster.ac_total = monster_data.get("ac_total", 10)
			monster.ac_touch = monster_data.get("ac_touch", 10)
			monster.ac_flatfooted = monster_data.get("ac_flatfooted", 10)
			# Merge the imported ac_modifiers with the default values
			var default_ac_modifiers = {"Armor": 0, "Dex": 0, "Dodge": 0, "Natural": 0}
			if "ac_modifiers" in monster_data:
				for key in monster_data["ac_modifiers"]:
					default_ac_modifiers[key] = monster_data["ac_modifiers"][key]
			monster.ac_modifiers = default_ac_modifiers
			
			monster.hp = monster_data.get("hp", 10)
			monster.hp_dice = monster_data.get("hp_dice", "1d8")
			monster.fort_save = monster_data.get("fort_save", 0)
			monster.ref_save = monster_data.get("ref_save", 0)
			monster.will_save = monster_data.get("will_save", 0)
			
			monster.defensive_abilities = monster_data.get("defensive_abilities", [])
			
			# Offense
			monster.speed = monster_data.get("speed", {"Burrow": 0, "Climb": 0, "Earth Glide": 0, "Fly": 0, "Jet": 0, "Swim": 0, "Walk": 0})
			monster.melee = monster_data.get("melee", [])
			monster.ranged = monster_data.get("ranged", [])
			monster.creatures_space = monster_data.get("creatures_space", 5)
			monster.creatures_reach = monster_data.get("creatures_reach", 5)
			
			monster.individual_attacks = monster_data.get("individual_attacks", [])
			
			monster.special_attacks = monster_data.get("special_attacks", [])
			
			# Statistics
			monster.strength = monster_data.get("strength", 10)
			monster.dexterity = monster_data.get("dexterity", 10)
			monster.constuition = monster_data.get("constuition", 10)
			monster.intelligence = monster_data.get("intelligence", 10)
			monster.wisdom = monster_data.get("wisdom", 10)
			monster.charisma = monster_data.get("charisma", 10)
			monster.base_atk = monster_data.get("base_atk", 0)
			monster.cmb = monster_data.get("cmb", 0)
			monster.cmd = monster_data.get("cmd", 0)
			
			# Special Qualities and Abilities
			monster.special_qualities = monster_data.get("special_qualities", [])
			
			monster.special_abilities = monster_data.get("special_abilities", {})
			
			monster.initiative_abilities = monster_data.get("initiative_abilities", [])
			
			monster.perception_bonus = monster_data.get("perception_bonus", 0)
			
			monster.aura = monster_data.get("aura", [])

			monster.hp_abilities = monster_data.get("hp_abilities", [])
			
			monster.weakness_abilities = monster_data.get("weaknee_abilities", [])
			
			# Spell-Like Abilities and Spells
			monster.spell_like_abilities = monster_data.get("spell_like_abilities", false)
			monster.spell_like_abilities_list = monster_data.get("spell_like_abilities_list", [])

			monster.immune=monster_data.get("immune", [])
			monster.languages=monster_data.get("languages", [])
						# Traits
			monster.archdevil_traits = monster_data.get("archdevil_traits", false)
			monster.demonlord_traits = monster_data.get("demonlord_traits", false)
			monster.empyreallord_traits = monster_data.get("empyreallord_traits", false)
			monster.formian_traits = monster_data.get("formian_traits", false)
			monster.horseman_traits = monster_data.get("horseman_traits", false)
			monster.qlippothlord_traits = monster_data.get("qlippothlord_traits", false)
			
			monster.perception_bonus=monster_data.get("perception_bonus",0)
			
			monster.spells = monster_data.get("spells", [])
			# Feats and Skills
			monster.feats = monster_data.get("feats", [])
			monster.skills = monster_data.get("skills", {"Acrobatics": 0, "Bluff": 0, "Climb": 0, "Diplomacy": 0, "Disable Device": 0, "Disguise": 0, "Escape Artist": 0, "Fly": 0, "Heal": 0, "Intimidate": 0, "Knowledge (arcana)": 0, "Knowledge (dungeoneering)": 0, "Knowledge (local)": 0, "Knowledge (nature)": 0, "Knowledge (planes)": 0, "Knowledge (religion)": 0, "Perception": 0, "Ride": 0, "Sense Motive": 0, "Spellcraft": 0, "Stealth": 0, "Survival": 0, "Swim": 0, "Use Magic Device": 0})

			# Ecology
			monster.enviroment = monster_data.get("enviroment", [])
			monster.organisation = monster_data.get("organisation", {"Minimum": 0, "Maximum": 0})
			
			# Playable Stats
			monster.depth = monster_data.get("depth", 0)
			
			#is recruit, initiaive and is_flat_footed will always be default
			monster.scene_path=monster_data.get("scene_path","")

			
			monster.initialize_required_xp()
			
			return monster
		else:
			print("Failed to parse JSON. Error code:", error)
	else:
		print("Failed to open file:", json_path)
	return null
