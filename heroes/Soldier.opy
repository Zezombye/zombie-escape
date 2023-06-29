#!mainFile "../ZombieEscape.opy"

rule "soldier healing - store biotic field position":
	@Event eachPlayer
	@Hero soldier
	@Condition eventPlayer.isUsingAbility2()
    eventPlayer.soldierHealPosition = eventPlayer.getPosition()

rule "soldier healing":
	@Event eachPlayer
	@Hero soldier
	@Condition eventPlayer.isUsingAbility2()
    do:
        heal([player for player in getPlayersInRadius(eventPlayer.soldierHealPosition, 4.5, Team.ALL, LosCheck.OFF) if player.team == TEAM_HUMANS], eventPlayer, 2.5)
        wait(0.016)
    while RULE_CONDITION
