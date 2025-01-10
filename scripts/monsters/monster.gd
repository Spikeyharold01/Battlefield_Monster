extends Node3D

class_name Monster  # Allows other scripts to reference it as Monster
enum Race {
	None,
	Dwarf,
	Elf,
	Gnome,
	Half_Elf,
	Half_Orc,
	Human,
	Catfolk,
	Duergar,
	Gnoll,
	Grippli,
	Goblin,
	Hobgoblin,
	Ifrit,
	Kobold,
	Lizardfolk,
	Monkey_Goblin,
	Orc,
	Oread,
	Ratfolk,
	Skinwalker,
	Sylph,
	Triaxian,
	Undine,
	Vanara,
	Aasimar,
	Android,
	Dhampir,
	Drow_Common,
	Fetchling,
	Gathlain,
	Ghoran,
	Kasatha,
	Lashunta,
	Shabti,
	Syrinx,
	Suli,
	Tengu,
	Tiefling,
	Vishkanya,
	Wyrwood,
	Wyvaran,
	Drow_Noble,
	Drider,
	Gargoyle,	
	Trox,
	Aquatic_Elf,
	Astomoi,
	Caligni,
	Changeling,
	Deep_One_Hybrid,
	Ganzi,
	Gillmen,
	Kitsune,
	Kuru,
	Merfolk,
	Munavri,
	Nagaji,
	Orang_Pendak,
	Reptoid,
	Samsaran,
	Strix,
	Wayang
} 
enum Character_Class {
	None,Barbarian,Bard,Cleric,Druid,Fighter,Monk,Paladin,Ranger,Rogue,Sorcerer,Wizard,
	Alchemist,Cavalier,Gunslinger,Inquisitor,Magus,Omdura,Oracle,Shifter,Summoner,Witch,Vampire_Hunter,Vigilante,
	Arcanist,Bloodrager,Brawler,Hunter,Invetigator,Shaman,Skald,slayer,Swashbuckler,Warpriest,
	Kineticist,Medium,Mesmerist,Occultist,Psychic,Spiritualist,
	Antipaladin,Ninja,Samurai
}
enum Alignment {
	Lawful_Good,Neutral_Good,Chaotic_Good,
	Lawful_Neutral,Neutral,Chaotic_Neutral,
	Lawful_Evil,Neutral_Evil,Chaotic_Evil
}
enum Creature_Size {
	Fine,Diminutive,Tiny,Small,Medium,Large,Huge,Gargantuan,Colossal
}
enum Creature_Type {
	Aberration,Animal,Construct,Dragon,Fey,Humanoid,Magical_Beast,Monstrous_Humanoid,Ooze,Outsider,Plant,Undead,Vermin
}

enum Scent {
	normal,strong,overpowering
}
@export var monster_name: String = "Unnamed Monster"

@export var cr: int
@export var xp: int =0
@export var present_xp: int =0
@export var required_xp: int


@export var race: Race
@export var character_class: Character_Class
@export var lvl: int =1

@export var alignment: Alignment
@export var creature_size: Creature_Size
@export var creature_type: Creature_Type

@export var init_mod: int
@export var normal_vision_range: float=250.0*0.3048
@export var senses: Dictionary={}
@export var auras: Dictionary={}
var active_auras = {}  # Dictionary to track active auras and their timers
@export var scent_strength: Scent = Scent.normal
#Defense
@export var ac_total: int
@export var ac_touch: int
@export var ac_flatfooted: int

@export var ac_modifiers: Dictionary ={
	"Armor":0, "Dex":0,"Dodge":0,"Natural":0
}

@export var hp: int
@export var hp_dice: String #Use Dice string (2d20+4)
@export var fort_save:int
@export var ref_save:int
@export var will_save:int

@export var defensive_abilities: Array=[]

#Offense
@export var speed: Dictionary ={"Burrow":0,"Climb":0,"Earth Glide":0,"Fly":0,"Jet":0,"Swim":0,"Walk":0}
@export var melee: Array=[]
@export var ranged: Array=[]
@export var creatures_space:int=5
@export var creatures_reach:int=5

@export var individual_attacks:Array=[]

@export var special_attacks: Array=[]

#statistics
@export var strength:int
@export var dexterity:int
@export var constuition:int
@export var intelligence:int
@export var wisdom:int
@export var charisma:int
@export var base_atk:int
@export var cmb:int
@export var cmd:int


@export var special_qualities: Array=[]


@export var special_abilities: Dictionary ={}



@export var initiative_abilities: Array=[]

@export var aura: Array=[]

@export var hp_abilities: Array=[]

@export var weakness_abilities: Array=[]

@export var spell_like_abilities: bool =false
@export var spell_like_abilities_list: Array=[]


@export var immune: Array=[]
@export var languages: Array=[]
@export var archdevil_traits: bool = false
@export var demonlord_traits: bool = false
@export var empyreallord_traits: bool = false
@export var formian_traits: bool = false
@export var horseman_traits: bool = false
@export var qlippothlord_traits: bool = false

@export var perception_bonus: int


# Exported array to hold spell resources
@export var spells: Array=[]

# Exported array to hold feats or abilities
@export var feats: Array = []
@export var skills: Dictionary ={"Acrobatics":0,"Bluff":0,"Climb":0,"Diplomacy":0,"Disable Device":0,
	"Disguise":0,"Escape Artist":0,"Fly":0,"Heal":0,"Intimidate":0,"Knowledge (arcana)":0,"Knowledge (dungeoneering)":0,"Knowledge (local)":0,
	"Knowledge (nature)":0,"Knowledge (planes)":0,"Knowledge (religion)":0,"Perception":0,"Ride":0,"Sense Motive":0,"Spellcraft":0,"Stealth":0,
	"Survival":0,"Swim":0,"Use Magic Device":0
	}
#ecology
@export var enviroment:Array = []
@export var organisation:Dictionary={"Minimum":0,"Maximum":0}
#playable stats map position etc

@export var depth: int = 0
@export var is_recruit: bool = false
@export var initiative: int =0
@export var is_flat_footed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func calculate_xp_threshold(level: int) -> int:
	var n = level + 1  # Adjust for n=1 corresponding to level 0
	if n <= 1:
		return 0  # Level 0 requires no XP
	return int(xp * pow(3, n - 2))
	
func initialize_required_xp():
	required_xp = calculate_xp_threshold(lvl)
