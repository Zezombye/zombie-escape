#!mainFile "ZombieEscape.opy"

settings {
    "main": {
        "description": "Zezombye's CS:S zombie escape v5.2.0 - code 3AZ61. Run from the zombies (torb/rein/winston/brig) to the end of the map! You must always go towards the trigger (blue). Zombies get knocked back by your bullets. At 1 second left all players are tp'd to the red orb (including zombies) so make sure to be near the point when 5 seconds are left! discord.gg/EEMjjFB"
    },
    "lobby": {
        "mapRotation": "afterGame",
        "enableMatchVoiceChat": true,
        "spectatorSlots": 9,
        "returnToLobby": "never"
    },
    "gamemodes": {
        "ffa": {
            "enabledMaps": [
                /*"blizzWorld",*/
                "blizzWorldWinter",
                /*"dorado",
                "eichenwalde",
                "eichenwaldeHalloween",
                "kingsRow",
                "kingsRowWinter",
                "oasisCityCenter"*/
            ]
        },
        "general": {
            "healthPackRespawnTime%": 25,
            "scoreToWin": 50,
            "enableSelfInitiatedRespawn": false
        }
    },
    "heroes": {
        "allTeams": {
            "ana": {
                "ability2Cooldown%": 200,
                "damageDealt%": 110
            },
            "ashe": {
                "damageDealt%": 60,
                "ability2Cooldown%": 500,
                "ability2FuseTime%": 1
            },
            "baptiste": {
                "damageDealt%": 115,
                "ability1Cooldown%": 250
            },
            "echo": {
                "enableAbility1": false,
                "enablePassive": false
            },
            "hanzo": {
                "enableAbility3": false,
                "ability2Cooldown%": 400,
                "ability2Quantity%": 8,
                "combatUltGen%": 105
            },
            "junkrat": {
                "damageDealt%": 80,
                "ability1Kb%": 0,
                "primaryFireKb%": 0
            },
            "pharah": {
                "damageReceived%": 10,
                "health%": 500,
                "enableSecondaryFireUnlimitedFuel": true
            },
            "reaper": {
                "damageDealt%": 120
            },
            "reinhardt": {
                "secondaryFireCooldown%": 50,
                "secondaryFireRechargeRate%": 200,
                "ability1Cooldown%": 50,
                "ability2Cooldown%": 0,
                "projectileSpeed%": 33,
                "enableSpawningWithUlt": true,
                "combatUltGen%": 250,
                "passiveUltGen%": 500,
                "ultGen%": 500
            },
            "soldier": {
                "ability2Cooldown%": 200,
                "damageDealt%": 80,
                "secondaryFireCooldown%": 200
            },
            "sombra": {
                "damageDealt%": 130
            },
            "torbjorn": {
                "ability2Cooldown%": 200,
                "ability2Duration%": 35,
                "weaponsEnabled": "hammer"
            },
            "tracer": {
                "damageDealt%": 125
            },
            "widowmaker": {
                "damageDealt%": 125
            },
            "winston": {
                "enableInfiniteUlt": true,
                "movementSpeed%": 85,
                "ultKb%": 25,
                "enableSpawningWithUlt": true
            },
            "zenyatta": {
                "damageDealt%": 95
            },
            "enabledHeroes": [
                "ana",
                "ashe",
                "baptiste",
                "echo",
                "hanzo",
                "junkrat",
                "mccree",
                "reaper",
                "soldier",
                "sombra",
                "tracer",
                "widowmaker",
                "zenyatta"
            ],
            "general": {
                "combatUltGen%": 150
            }
        }
    }
}

