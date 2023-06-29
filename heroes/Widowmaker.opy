#!mainFile "../ZombieEscape.opy"

rule "widow no primary when unscoped, except with ult":
	@Event eachPlayer
	@Hero widowmaker
	@Condition roundStatus >= GAME_IN_PROGRESS and not eventPlayer.isFiringSecondaryFire() and not eventPlayer.isUsingUltimate()
    eventPlayer.setPrimaryFireEnabled(false)

rule "widow allow primary when scoped/ult":
	@Event eachPlayer
	@Hero widowmaker
	@Condition roundStatus >= GAME_IN_PROGRESS and (eventPlayer.isFiringSecondaryFire() or eventPlayer.isUsingUltimate())
    eventPlayer.setPrimaryFireEnabled(true)
