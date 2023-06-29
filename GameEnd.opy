#!mainFile "ZombieEscape.opy"

#!define winHud(str, pos, sortOrder) hudSubheader([player for player in getAllPlayers() if displayZombiesWinText or displayHumansWinText], str, pos, sortOrder, Color.RED, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)

#!define zombiesWinHud(str, pos, sortOrder) hudSubheader([player for player in getAllPlayers() if displayZombiesWinText], str, pos, sortOrder, Color.RED, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
#!define humansWinHudLeft(str, sortOrder) hudSubheader([player for player in getAllPlayers() if displayHumansWinText], str, HudPosition.LEFT, sortOrder, Color.SKY_BLUE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)
#!define humansWinHudRight(str, sortOrder) hudSubheader([player for player in getAllPlayers() if displayHumansWinText], str, HudPosition.RIGHT, sortOrder, Color.BLUE, HudReeval.VISIBILITY, SpecVisibility.DEFAULT)

rule "setup victory screens":
    @Event global
    
    #@Condition roundWinners != NO_TEAM
    @Condition createWinTextHuds

    #8x normal lines = 9 blizzard global lines.
    #By putting 8x blizzard global lines + 1 normal line, there is a shift of 1-2 px between the two sides, which is enough to cover the gaps.
    winHud(" ", HudPosition.LEFT, -600)

    #Put these directly in the messages to save 1 more hud.
    #winHud(b" \n\n\n\n\n\n\n", HudPosition.LEFT, -600)
    winHud(" \n\n\n\n\n\n\n", HudPosition.RIGHT, -600)

rule "zombies win":
    @Event global
    #@Condition dispZomb
	#@Condition roundWinners == TEAM_ZOMBIES
    #@Condition hostPlayer.isHoldingButton(Button.INTERACT)
    @Condition createWinTextHuds
    
    wait(0.032)
    #left HUD
    zombiesWinHud(" \n\n\n\n\n\n\n\n                            ▒▒▒▒▒▒    ▒▒▒▒             ▒▒         ▒▒▒▒                               ▒▒   ▒▒", HudPosition.LEFT, -500)
    zombiesWinHud("                           ▒▒▒▒▒▒▒   ▒▒▒▒▒▒            ▒▒        ▒▒▒▒▒▒                             ▒▒▒   ▒▒", HudPosition.LEFT, -499)
    wait()
    zombiesWinHud("                           ▒▒ ▒▒▒▒  ▒▒▒ ▒▒▒            ▒▒        ▒▒ ▒ ▒▒                            ▒▒▒▒  ▒▒", HudPosition.LEFT, -498)
    zombiesWinHud("                              ▒▒▒  ▒▒▒▒ ▒ ▒▒  ▒▒ ▒▒   ▒▒▒▒▒  ▒▒  ▒▒    ▒  ▒▒▒▒      ▒▒      ▒▒ ▒▒   ▒▒▒▒  ▒▒", HudPosition.LEFT, -497)
    wait()
    zombiesWinHud("                             ▒▒▒▒  ▒▒   ▒ ▒▒  ▒▒▒▒▒▒  ▒▒▒▒▒▒ ▒▒  ▒▒▒▒▒ ▒ ▒▒▒▒▒      ▒▒      ▒▒ ▒▒   ▒▒▒▒▒ ▒▒", HudPosition.LEFT, -496)
    zombiesWinHud("                            ▒▒▒ ▒  ▒▒   ▒ ▒▒ ▒▒▒▒▒▒▒▒ ▒▒▒ ▒▒ ▒▒  ▒▒▒▒▒   ▒▒▒        ▒▒  ▒▒  ▒▒ ▒▒  ▒▒▒▒▒▒▒▒▒", HudPosition.LEFT, -495)
    wait()
    zombiesWinHud("                           ▒▒▒  ▒  ▒▒     ▒▒ ▒▒ ▒▒ ▒▒ ▒▒  ▒▒ ▒▒▒ ▒▒  ▒    ▒▒▒       ▒▒▒▒▒▒▒ ▒▒ ▒▒▒ ▒▒ ▒▒▒▒▒▒", HudPosition.LEFT, -494)
    zombiesWinHud("                           ▒▒▒     ▒▒▒   ▒▒  ▒▒ ▒▒ ▒▒ ▒▒  ▒▒ ▒▒▒ ▒▒▒       ▒▒▒       ▒▒▒▒▒▒▒▒  ▒▒▒ ▒▒ ▒ ▒▒▒▒", HudPosition.LEFT, -493)
    wait()
    zombiesWinHud("                           ▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒  ▒▒ ▒▒ ▒▒ ▒▒▒▒▒▒  ▒▒ ▒▒▒▒▒▒▒ ▒▒▒▒▒       ▒▒▒  ▒▒▒   ▒▒ ▒▒   ▒▒▒▒", HudPosition.LEFT, -492)
    zombiesWinHud("                           ▒ ▒▒▒▒▒  ▒▒▒▒▒ ▒  ▒▒ ▒▒ ▒▒  ▒▒▒▒   ▒▒ ▒ ▒▒▒▒   ▒▒▒         ▒    ▒    ▒▒ ▒▒   ▒▒  ", HudPosition.LEFT, -491)
    wait()
    zombiesWinHud("                               ▒ ▒  ▒ ▒▒▒ ▒     ▒      ▒▒     ▒   ▒▒  ▒    ▒               ▒    ▒   ▒   ▒▒  ", HudPosition.LEFT, -490)
    zombiesWinHud("                               ▒ ▒     ▒               ▒          ▒▒                       ▒▒           ▒▒▒ ", HudPosition.LEFT, -489)
    wait()
    zombiesWinHud("                               ▒                       ▒▒         ▒▒                        ▒            ▒▒ ", HudPosition.LEFT, -488)
    zombiesWinHud("                               ▒                        ▒          ▒                        ▒            ▒▒ ", HudPosition.LEFT, -487)
    wait()
    zombiesWinHud("                               ▒▒                       ▒          ▒                        ▒▒            ▒ ", HudPosition.LEFT, -486)
    zombiesWinHud("                                ▒                       ▒          ▒                         ▒            ▒ ", HudPosition.LEFT, -485)
    wait()
    zombiesWinHud("                                                                                                         ▒▒ \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.LEFT, -484)
    #zombiesWinHud("                                                                                                         ▒  ", HudPosition.LEFT, -483)

    #right HUD
    zombiesWinHud(" ▒▒▒▒▒▒    ▒▒▒▒             ▒▒         ▒▒▒▒                               ▒▒   ▒▒                          ", HudPosition.RIGHT, -500)
    wait()
    zombiesWinHud("▒▒▒▒▒▒▒   ▒▒▒▒▒▒            ▒▒        ▒▒▒▒▒▒                             ▒▒▒   ▒▒                          ", HudPosition.RIGHT, -499)
    zombiesWinHud("▒▒ ▒▒▒▒  ▒▒▒ ▒▒▒            ▒▒        ▒▒ ▒ ▒▒                            ▒▒▒▒  ▒▒                          ", HudPosition.RIGHT, -498)
    wait()
    zombiesWinHud("   ▒▒▒  ▒▒▒▒ ▒ ▒▒  ▒▒ ▒▒   ▒▒▒▒▒  ▒▒  ▒▒    ▒  ▒▒▒▒      ▒▒      ▒▒ ▒▒   ▒▒▒▒  ▒▒                          ", HudPosition.RIGHT, -497)
    zombiesWinHud("  ▒▒▒▒  ▒▒   ▒ ▒▒  ▒▒▒▒▒▒  ▒▒▒▒▒▒ ▒▒  ▒▒▒▒▒ ▒ ▒▒▒▒▒      ▒▒      ▒▒ ▒▒   ▒▒▒▒▒ ▒▒                          ", HudPosition.RIGHT, -496)
    wait()
    zombiesWinHud(" ▒▒▒ ▒  ▒▒   ▒ ▒▒ ▒▒▒▒▒▒▒▒ ▒▒▒ ▒▒ ▒▒  ▒▒▒▒▒   ▒▒▒        ▒▒  ▒▒  ▒▒ ▒▒  ▒▒▒▒▒▒▒▒▒                          ", HudPosition.RIGHT, -495)
    zombiesWinHud("▒▒▒  ▒  ▒▒     ▒▒ ▒▒ ▒▒ ▒▒ ▒▒  ▒▒ ▒▒▒ ▒▒  ▒    ▒▒▒       ▒▒▒▒▒▒▒ ▒▒ ▒▒▒ ▒▒ ▒▒▒▒▒▒                          ", HudPosition.RIGHT, -494)
    wait()
    zombiesWinHud("▒▒▒     ▒▒▒   ▒▒  ▒▒ ▒▒ ▒▒ ▒▒  ▒▒ ▒▒▒ ▒▒▒       ▒▒▒       ▒▒▒▒▒▒▒▒  ▒▒▒ ▒▒ ▒ ▒▒▒▒                          ", HudPosition.RIGHT, -493)
    zombiesWinHud("▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒  ▒▒ ▒▒ ▒▒ ▒▒▒▒▒▒  ▒▒ ▒▒▒▒▒▒▒ ▒▒▒▒▒       ▒▒▒  ▒▒▒   ▒▒ ▒▒   ▒▒▒▒                          ", HudPosition.RIGHT, -492)
    wait()
    zombiesWinHud("▒ ▒▒▒▒▒  ▒▒▒▒▒ ▒  ▒▒ ▒▒ ▒▒  ▒▒▒▒   ▒▒ ▒ ▒▒▒▒   ▒▒▒         ▒    ▒    ▒▒ ▒▒   ▒▒                            ", HudPosition.RIGHT, -491)
    zombiesWinHud("    ▒ ▒  ▒ ▒▒▒ ▒     ▒      ▒▒     ▒   ▒▒  ▒    ▒               ▒    ▒   ▒   ▒▒                            ", HudPosition.RIGHT, -490)
    wait()
    zombiesWinHud("    ▒ ▒     ▒               ▒          ▒▒                       ▒▒           ▒▒▒                           ", HudPosition.RIGHT, -489)
    zombiesWinHud("    ▒                       ▒▒         ▒▒                        ▒            ▒▒                           ", HudPosition.RIGHT, -488)
    wait()
    zombiesWinHud("    ▒                        ▒          ▒                        ▒            ▒▒                           ", HudPosition.RIGHT, -487)
    zombiesWinHud("    ▒▒                       ▒          ▒                        ▒▒            ▒                           ", HudPosition.RIGHT, -486)
    wait()
    zombiesWinHud("     ▒                       ▒          ▒                         ▒            ▒                           ", HudPosition.RIGHT, -485)
    zombiesWinHud("▒▒                           \n▒                            \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.RIGHT, -483)


rule "humans win":
    @Event global
    #@Condition roundWinners == TEAM_HUMANS
    @Condition createWinTextHuds
    
    wait(0.032)
    #left HUD
    humansWinHudLeft(" \n\n\n\n\n\n\n\n                                  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒              ", -500)
    humansWinHudLeft("                                  ▒▒                                                                ▒▒              ", -499)
    wait()
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒", -498)
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒", -497)
    wait()
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒▒▒      ▒▒▒▒", -496)
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                            ▒                                   ▒▒▒▒▒▒      ▒▒▒▒", -495)
    wait()
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒ ▒▒    ▒▒ ▒      ▒        ▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒       ▒▒    ▒▒ ▒▒ ▒▒▒▒▒▒▒▒    ▒▒▒▒", -494)
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒ ▒▒    ▒▒ ▒▒    ▒▒       ▒▒ ▒▒▒   ▒▒ ▒▒▒▒▒▒▒▒       ▒▒    ▒▒ ▒▒ ▒▒▒▒▒▒▒▒    ▒▒▒▒", -493)
    wait()
    humansWinHudLeft("                    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒  ▒▒▒      ▒▒▒ ▒▒▒▒  ▒▒ ▒▒             ▒▒ ▒▒ ▒▒ ▒▒ ▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒", -492)
    humansWinHudLeft("                    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒     ▒▒▒▒ ▒▒▒▒▒ ▒▒ ▒▒▒▒▒▒▒▒       ▒▒▒▒▒▒▒▒ ▒▒ ▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒", -491)
    wait()
    humansWinHudLeft("                    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒    ▒▒▒▒▒ ▒▒ ▒▒▒▒▒ ▒▒▒▒▒▒▒▒       ▒▒▒▒▒▒▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒", -490)
    humansWinHudLeft("                    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒ ▒▒ ▒▒   ▒▒▒ ▒▒ ▒▒  ▒▒▒▒       ▒▒       ▒▒▒  ▒▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒", -489)
    wait()
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒ ▒▒▒▒▒▒▒▒ ▒▒    ▒▒  ▒▒▒  ▒▒ ▒▒   ▒▒▒ ▒▒▒▒▒▒▒▒       ▒▒    ▒▒ ▒▒ ▒▒▒▒    ▒▒▒▒▒▒▒▒", -488)
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒ ▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒   ▒▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒       ▒      ▒ ▒▒ ▒▒▒▒    ▒▒▒▒▒▒▒▒", -487)
    wait()
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                                   ▒                            ▒▒▒▒      ▒▒▒▒▒▒", -486)
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒      ▒▒▒▒▒▒", -485)
    wait()
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒", -484)
    humansWinHudLeft("                    ▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒", -483)
    wait()
    humansWinHudLeft("                    ▒▒                                                                                            ▒▒", -482)
    humansWinHudLeft("                    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", -481)


    wait()
    #right HUD
    humansWinHudRight("              ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                                ", -500)
    humansWinHudRight("              ▒▒                                                                ▒▒                                ", -499)
    wait()
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒                  ", -498)
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒                  ", -497)
    wait()
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒▒▒      ▒▒▒▒                  ", -496)
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                            ▒                                   ▒▒▒▒▒▒      ▒▒▒▒                  ", -495)
    wait()
    humansWinHudRight("▒▒▒▒        ▒▒▒▒ ▒▒    ▒▒ ▒      ▒        ▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒       ▒▒    ▒▒ ▒▒ ▒▒▒▒▒▒▒▒    ▒▒▒▒                  ", -494)
    humansWinHudRight("▒▒▒▒        ▒▒▒▒ ▒▒    ▒▒ ▒▒    ▒▒       ▒▒ ▒▒▒   ▒▒ ▒▒▒▒▒▒▒▒       ▒▒    ▒▒ ▒▒ ▒▒▒▒▒▒▒▒    ▒▒▒▒                  ", -493)
    wait()
    humansWinHudRight("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒  ▒▒▒      ▒▒▒ ▒▒▒▒  ▒▒ ▒▒             ▒▒ ▒▒ ▒▒ ▒▒ ▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒                  ", -492)
    humansWinHudRight("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒     ▒▒▒▒ ▒▒▒▒▒ ▒▒ ▒▒▒▒▒▒▒▒       ▒▒▒▒▒▒▒▒ ▒▒ ▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒                  ", -491)
    wait()
    humansWinHudRight("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒    ▒▒▒▒▒ ▒▒ ▒▒▒▒▒ ▒▒▒▒▒▒▒▒       ▒▒▒▒▒▒▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒                  ", -490)
    humansWinHudRight("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒ ▒▒ ▒▒   ▒▒▒ ▒▒ ▒▒  ▒▒▒▒       ▒▒       ▒▒▒  ▒▒▒ ▒▒ ▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒                  ", -489)
    wait()
    humansWinHudRight("▒▒▒▒        ▒▒▒▒ ▒▒▒▒▒▒▒▒ ▒▒    ▒▒  ▒▒▒  ▒▒ ▒▒   ▒▒▒ ▒▒▒▒▒▒▒▒       ▒▒    ▒▒ ▒▒ ▒▒▒▒    ▒▒▒▒▒▒▒▒                  ", -488)
    humansWinHudRight("▒▒▒▒        ▒▒▒▒ ▒▒▒▒▒▒▒▒ ▒▒    ▒▒ ▒▒▒   ▒▒ ▒▒    ▒▒ ▒▒▒▒▒▒▒▒       ▒      ▒ ▒▒ ▒▒▒▒    ▒▒▒▒▒▒▒▒                  ", -487)
    wait()
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                                   ▒                            ▒▒▒▒      ▒▒▒▒▒▒                  ", -486)
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒      ▒▒▒▒▒▒                  ", -485)
    wait()
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒                  ", -484)
    humansWinHudRight("▒▒▒▒        ▒▒▒▒                                                                ▒▒▒▒        ▒▒▒▒                  ", -483)
    wait()
    humansWinHudRight("▒▒                                                                                            ▒▒                  ", -482)
    humansWinHudRight("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                  \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", -481)
    