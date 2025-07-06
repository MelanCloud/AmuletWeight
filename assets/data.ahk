Config := Map(
    "Hotkey",Map(
        "buffScan","F6",
        "buffScanInGame","F7",
        "autoSelectToggle","F8",
        "autoSelectOnOff","F9"
    )
)

Colors := ["White", "Red", "Blue"],
Flowers := ["Single", "Double", "Triple"],

endWeights := Map("Overall",0, "White",0, "Red",0, "Blue",0),
Amulets := Map(
    "Star",Map(
        "Buffs",Map(
            "xCAP",0,
            "P",0,
            "RED_P",0,
            "BLUE_P",0,
            "WHITE_P",0,
            "BEE_P",0,
            "CONV_IST",0,
            "xCONV_RTE",0,
            "TOKEN_RTE",0,
            "CRIT_CH",0
        ),
        "Validation",Map(
            "Required",["xCAP"],
            "Varying",[["P", "RED_P", "BLUE_P", "WHITE_P", "BEE_P", "CONV_IST", "xCONV_RTE", "TOKEN_RTE", "CRIT_CH"]]
        ),
        "Checks",Map(), "Values",Map(),
        "Regex","Star"
    ),
    "Moon",Map(
        "Buffs",Map(
            "CAP",0,
            "WHITE_P",0,
            "BOND_T",0,
            "CONV_IST",0,
            "HONEY_P",0,
            "P",0,
            "BEE_P",0,
            "TOOL_P",0,
            "F1",0,
            "F1_Value",0,
            "BOND_B",0,
            "TICKET_CH",0,
            "MOVE_C",0
        ),
        "Validation",Map(
            "Required",["CAP"],
            "Varying",[["WHITE_P", "BOND_T"], ["CONV_IST", "HONEY_P", "P", "BEE_P", "TOOL_P", "F1", "F1_Value", "BOND_B"]]
        ),
        "Checks",Map(), "Values",Map(),
        "Regex","Moon"
    ),
    "KingBeetle",Map(
        "Buffs",Map(
            "CONV_RTE",0,
            "F1",0,
            "F1_Value",0,
            "F2",0,
            "F2_Value",0,
            "ATK",0,
            "ATK_RED",0,
            "ATK_BLUE",0
        ),
        "Validation",Map(
            "Required",["CONV_RTE", "F1", "F1_Value", "F2", "F2_Value"]
        ),
        "Checks",Map(), "Values",Map(),
        "Regex","King"
    ),
    "Ant",Map(
        "Buffs",Map(
            "CONV_RTE",0,
            "CRIT_CH",0,
            "CRIT_PW",0,
            "ATK",0,
            "MOVE_S",0,
            "P",0,
            "RED_P",0,
            "BLUE_P",0,
            "WHITE_P",0
        ),
        "Validation",Map("Required",["CONV_RTE"]),
        "Checks",Map(), "Values",Map(),
        "Regex","Ant"
    ),
    "Shell",Map(
        "Buffs",Map(
            "GOO",0,
            "F1",0,
            "F1_Value",0,
            "CONV_AMT",0,
            "CONV_GOO",0,
            "TOKEN_H",0,
            "P",0,
            "WHITE_P",0,
            "TOOL_P",0,
            "BOND_B",0,
            "DEF",0,
            "F2",0,
            "F2_Value",0,
            "F3",0,
            "F3_Value",0,
            "F4",0,
            "F4_Value",0
        ),
        "Validation",Map(
            "Required",["GOO", "F1", "F1_Value"],
            "Varying",[["CONV_AMT", "CONV_GOO", "TOKEN_H", "P", "WHITE_P", "TOOL_P", "BOND_B", "DEF"], ["F2", "F2_Value", "F3", "F3_Value", "F4", "F4_Value"]]
        ),
        "Checks",Map(), "Values",Map(),
        "Regex","Shell"
    ),
    "StickBug",Map(
        "Buffs",Map(
            "CAP",0,
            "xCONV_RTE",0,
            "ATK_RED",0,
            "ATK_BLUE",0,
            "P",0,
            "WHITE_P",0,
            "RED_P",0,
            "BLUE_P",0,
            "ATK_PW",0,
            "P_BOMB",0,
            "P_BOMB_RED",0,
            "P_BOMB_BLUE",0,
            "P_BOMB_BUZZ",0,
            "TOKEN_H",0,
            "RESPAWN",0,
            "BOND_B",0,
            "ATK",0,
            "TOOL_P",0
        ),
        "Validation",Map(
            "Required",["CAP", "xCONV_RTE"],
            "Varying",[["ATK_RED", "ATK_BLUE"], ["P", "WHITE_P", "RED_P", "BLUE_P"], ["ATK_PW", "P_BOMB", "P_BOMB_RED", "P_BOMB_BLUE", "P_BOMB_BUZZ", "TOKEN_H"]]
        ),
        "Checks",Map(), "Values",Map(),
        "Regex","Bug"
    ),
    "Cog",Map(
        "Buffs",Map(
            "CAP",0,
            "ATK_PW",0,
            "ATK_RED",0,
            "ATK_BLUE",0,
            "ATK_COLORLESS",0,
            "P",0,
            "WHITE_P",0,
            "RED_P",0,
            "BLUE_P",0,
            "CONV_IST_WHITE",0,
            "CONV_IST_RED",0,
            "CONV_IST_BLUE",0,
            "ABILITY_EVENT",0,
            "ABILITY_MARK",0,
            "FLAME_P",0,
            "BUBBLE_P",0,
            "BEE_P",0,
            "TOKEN_LFS",0,
            "TOKEN_H",0,
            "CRIT_PW_S",0,
            "NECTAR",0
        ),
        "Validation",Map(
            "Required",["CAP"],
            "Varying",[["ATK_PW", "ATK_RED", "ATK_BLUE", "ATK_COLORLESS"], ["P", "RED_P", "BLUE_P", "WHITE_P"], ["CONV_IST_WHITE", "CONV_IST_RED", "CONV_IST_BLUE"]]
        ),
        "Checks",Map(), "Values",Map(),
        "Regex","Cog"
    ),
),

Buffs := Map(
    "CAP",           Map("Weight",0.004,  "Regex","\+\d+ Cap"              ),
    "xCAP",          Map("Weight",500,    "Regex","x\d+(.\d+)? Cap"        ),
    "CONV_IST",      Map("Weight",100,    "Regex","\+\d+% Instant Co"      ),
    "CONV_IST_WHITE",Map(                 "Regex","\+\d+% Instant White Co"),
    "CONV_IST_RED",  Map(                 "Regex","\+\d+% Instant Red Co"  ),
    "CONV_IST_BLUE", Map(                 "Regex","\+\d+% Instant Blue Co" ),
    "CONV_GOO",      Map("Weight",30,     "Regex","\+\d+% Goo Co"          ),
    "CONV_RTE",      Map("Weight",13,     "Regex","\+\d+% Convert Rat"     ),
    "xCONV_RTE",     Map("Weight",250,    "Regex","x\d+(.\d+)? Convert Rat"),
    "CONV_AMT",      Map("Weight",10,     "Regex","\+\d+ Convert Amo"      ),
    "P_BOMB",        Map("Weight",30,     "Regex","\+\d+% Bomb Poll"       ),
    "P_BOMB_RED",    Map(                 "Regex","\+\d+% Red Bomb"        ),
    "P_BOMB_BLUE",   Map(                 "Regex","\+\d+% Blue Bomb"       ),
    "P_BOMB_BUZZ",   Map(                 "Regex","\+\d+% Buzz Bomb"       ),
    "ABILITY_EVENT", Map("Weight",20,     "Regex","\+\d+% Event"           ),
    "ABILITY_MARK",  Map("Weight",20,     "Regex","\+\d+% Mark"            ),
    "FLAME_P",       Map(                 "Regex","\+\d+% Flame"           ),
    "BUBBLE_P",      Map(                 "Regex","\+\d+% Bubble"          ),
    "TOKEN_LFS",     Map("Weight",25,     "Regex","\+\d+% Ability Tok"     ),
    "TOKEN_RTE",     Map("Weight",10,     "Regex","\+\d+% Bee Abil"        ),
    "TOKEN_H",       Map("Weight",15,     "Regex","\+\d+% Honey From"      ),
    "GOO",           Map("Weight",30,     "Regex","\+\d+% Goo$"            ),
    "HONEY_P",       Map("Weight",100,    "Regex","\+\d+% Honey Per"       ),
    "P",             Map("Weight",80,     "Regex","\+\d+% Pollen$"         ),
    "BEE_P",         Map("Weight",50,     "Regex","\+\d+% Pollen From B"   ),
    "TOOL_P",        Map("Weight",25,     "Regex","\+\d+% Pollen From T"   ),
    "RED_P",         Map(                 "Regex","\+\d+% Red Poll"        ),
    "BLUE_P",        Map(                 "Regex","\+\d+% Blue Poll"       ),
    "WHITE_P",       Map(                 "Regex","\+\d+% White Poll"      ),
    "NECTAR",        Map("Weight",50,     "Regex","\+\d+% Nectar"          ),
    "MOVE_S",        Map("Weight",75,     "Regex","\+\d+ Player Move"      ),
    "MOVE_C",        Map("Weight",50,     "Regex","\+\d+ Move"             ),
    "RESPAWN",       Map("Weight",100,    "Regex","-\d+% Monster"          ),
    "CRIT_CH",       Map("Weight",100,    "Regex","\+\d+% Critical C"      ),
    "CRIT_PW",       Map("Weight",10,     "Regex","\+\d+% Critical P"      ),
    "CRIT_PW_S",     Map("Weight",30,     "Regex","\+\d+% Super-Crit P"    ),
    "DEF",           Map("Weight",50,     "Regex","\+\d+% Defense"         ),
    "ATK",           Map("Weight",250,    "Regex","\+\d+ Bee Attack"       ),
    "ATK_RED",       Map(                 "Regex","\+\d+ Red Bee"          ),
    "ATK_BLUE",      Map(                 "Regex","\+\d+ Blue Bee"         ),
    "ATK_COLORLESS", Map("Weight",150,    "Regex","\+\d+ Colorless Bee"    ),
    "ATK_PW",        Map("Weight",100,    "Regex","\+\d+% Bee Attack"      ),
    "BOND_T",        Map("Weight",10,     "Regex","\+\d+% Bond From T"     ),
    "BOND_B",        Map("Weight",10,     "Regex","\+\d+% Bond From B"     ),
    "TICKET_CH",     Map("Weight",50,     "Regex","\+\d+% Tick"            )
),
Buffs["FLAME_P"]["Weights"] := Map(
    "White",10,
    "Blue",5,
    "Red",20
),
Buffs["BUBBLE_P"]["Weights"] := Map(
    "White",10,
    "Blue",20,
    "Red",5
),
Buffs["P_BOMB_RED"]["Weights"] := Map(
    "White",10,
    "Blue",5,
    "Red",20
),
Buffs["P_BOMB_BLUE"]["Weights"] := Map(
    "White",10,
    "Blue",20,
    "Red",5
),
Buffs["P_BOMB_BUZZ"]["Weights"] := Map(
    "White",20,
    "Blue",10,
    "Red",1
),
Buffs["RED_P"]["Weights"] := Map(
    "White",10,
    "Blue",10,
    "Red",50
),
Buffs["BLUE_P"]["Weights"] := Map(
    "White",10,
    "Blue",50,
    "Red",10
),
Buffs["WHITE_P"]["Weights"] := Map(
    "White",50,
    "Blue",10,
    "Red",10
),
Buffs["ATK_RED"]["Weights"] := Map(
    "White",150,
    "Blue",125,
    "Red",200
),
Buffs["ATK_BLUE"]["Weights"] := Map(
    "White",150,
    "Blue",200,
    "Red",125
),
Buffs["CONV_IST_WHITE"]["Weights"] := Map(
    "White",100,
    "Blue",30,
    "Red",30
),
Buffs["CONV_IST_RED"]["Weights"] := Map(
    "White",30,
    "Blue",30,
    "Red",100
),
Buffs["CONV_IST_BLUE"]["Weights"] := Map(
    "White",30,
    "Blue",100,
    "Red",30
),

Stars := Map(
    "Pop Star",      Map("Has",0, "Regex","\+Passive: Pop"     ),
    "Guiding Star",  Map("Has",0, "Regex","\+Passive: Guid"    ),
    "Star Shower",   Map("Has",0, "Regex","\+Passive: Star Sho"),
    "Gummy Star",    Map("Has",0, "Regex","\+Passive: Gum"     ),
    "Scorching Star",Map("Has",0, "Regex","\+Passive: Scor"    ),
    "Star Saw",      Map("Has",0, "Regex","\+Passive: Star Saw")
),
Stars["Pop Star"]["Weights"] := Map(
    "White",300,
    "Blue",900,
    "Red",300
),
Stars["Guiding Star"]["Weights"] := Map(
    "White",600,
    "Blue",900,
    "Red",600
),
Stars["Star Shower"]["Weights"] := Map(
    "White",900,
    "Blue",900,
    "Red",600
),
Stars["Gummy Star"]["Weights"] := Map(
    "White",900,
    "Blue",600,
    "Red",600
),
Stars["Scorching Star"]["Weights"] := Map(
    "White",300,
    "Blue",300,
    "Red",900
),
Stars["Star Saw"]["Weights"] := Map(
    "White",900,
    "Blue",600,
    "Red",900
),

Fields := Map(
    "Cactus",Map(
        "White",Map(
            "Triple",3,
            "Double",4
        ),
        "Red",Map(
            "Triple",25,
            "Double",18
        ),
        "Blue",Map(
            "Triple",28,
            "Double",22
        )
    ),
    "Pumpkin",Map(
        "White",Map(
            "Triple",43,
            "Double",14
        ),
        "Red",Map(
            "Triple",16,
            "Double",5
        ),
        "Blue",Map(
            "Triple",17,
            "Double",5
        )
    ),
    "Pineapple",Map(
        "White",Map(
            "Triple",27,
            "Double",45,
            "Single",17
        ),
        "Red",Map(
            "Triple",2,
            "Double",3,
            "Single",1
        ),
        "Blue",Map(
            "Triple",2,
            "Double",2,
            "Single",1
        )
    ),
    "Stump",Map(
        "White",Map("Triple",19),
        "Red",Map("Triple",6),
        "Blue",Map("Triple",75)
    ),
    "Spider",Map(
        "White",Map(
            "Triple",10,
            "Double",80,
            "Single",10
        )
    ),
    "Strawberry",Map(
        "White",Map(
            "Triple",1,
            "Double",23,
            "Single",7
        ),
        "Red",Map(
            "Triple",3,
            "Double",52,
            "Single",14
        )
    ),
    "Bamboo",Map(
        "White",Map(
            "Triple",1.25,
            "Double",18.75,
            "Single",5
        ),
        "Blue",Map(
            "Triple",3.75,
            "Double",56.25,
            "Single",15
        )
    ),
    "Dandelion",Map(
        "White",Map(
            "Double",10.6,
            "Single",74.1
        ),
        "Red",Map(
            "Double",0.8,
            "Single",4.8
        ),
        "Blue",Map(
            "Double",1.5,
            "Single",8.2
        )
    ),
    "Sunflower",Map(
        "White",Map(
            "Double",6.4,
            "Single",61.9
        ),
        "Red",Map(
            "Double",1.7,
            "Single",15
        ),
        "Blue",Map(
            "Double",2.1,
            "Single",12.9
        )
    ),
    "Clover",Map(
        "White",Map(
            "Double",16,
            "Single",16
        ),
        "Red",Map(
            "Double",16,
            "Single",18
        ),
        "Blue",Map(
            "Double",17,
            "Single",17
        )
    ),
    "Mushroom",Map(
        "White",Map(
            "Double",2.8,
            "Single",27.8
        ),
        "Red",Map(
            "Double",6.9,
            "Single",61.5
        )
    ),
    "Blue Flower",Map(
        "White",Map(
            "Double",3,
            "Single",28
        ),
        "Blue",Map(
            "Double",8,
            "Single",61
        )
    )
),
FieldData := Map(
    "Divisor",30,
    "Types",Map(
        "Single",Map("Factor",1, "Value",0),
        "Double",Map("Factor",4, "Value",0),
        "Triple",Map("Factor",8, "Value",0)
    )
)
