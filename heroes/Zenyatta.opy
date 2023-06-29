#!mainFile "../ZombieEscape.opy"

rule "chase timer":
	@Event eachPlayer
	chase(eventPlayer.zenCharge, 9999, rate=1, ChaseReeval.NONE)

rule "prevent using ultimate unless using right click":
	@Event eachPlayer
	@Hero zenyatta
	@Condition eventPlayer.getUltCharge() > 0
    eventPlayer.disallowButton(Button.ULTIMATE)

rule "inform player that he must press rclick":
	@Event eachPlayer
	@Hero zenyatta
	@Condition eventPlayer.isHoldingButton(Button.ULTIMATE) and eventPlayer.getUltCharge() == 100
    smallMessage(eventPlayer, "Charge secondary fire to use your ultimate!")


rule "zen fast fire - charging":
	@Event eachPlayer
	@Hero zenyatta
	@Condition eventPlayer.isFiringSecondaryFire()
    eventPlayer.zenCharge = 0
    #chase(eventPlayer.zenCharge, 9999, rate=1, ChaseReeval.NONE)

/*
rule "zen fast fire - releasing":
	@Event eachPlayer
	@Hero zenyatta
	@Condition not eventPlayer.isFiringSecondaryFire()
    stopChasingVariable(eventPlayer.zenCharge)
    eventPlayer.zenCharge = 0
*/

rule "charged enough":
	@Event eachPlayer
	@Hero zenyatta
	@Condition eventPlayer.getUltCharge() == 100 and eventPlayer.zenCharge > 0.75 and eventPlayer.isFiringSecondaryFire()
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ULTIMATE)
    wait()
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)


rule "zen fast fire - firing + trans healing":
	@Event eachPlayer
	@Hero zenyatta
	@Condition eventPlayer.isUsingUltimate()
    do:
        eventPlayer.setProjectileSpeed(100)
        heal([player for player in getPlayersInRadius(eventPlayer.getPosition(), 10, Team.ALL, LosCheck.OFF) if player.team == TEAM_HUMANS], eventPlayer, 3)
        wait(0.016)
    while RULE_CONDITION