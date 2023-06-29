#!mainFile "zombieescape.opy"
/*
rule "(debug) section spheres draw":
	@Event global
	@Condition ENABLE_DEBUG and sectionLoopIndex == 0
    wait(2)
    createEffect(getAllPlayers(), Effect.SPHERE, Color.WHITE, triggers[currentSection], sectionRadiuses[currentSection], IconReeval.VISIBILITY)


rule "(debug) tp":
	@Event eachPlayer
	@Condition ENABLE_DEBUG and eventPlayer.isHoldingButton(Button.INTERACT)
    eventPlayer.teleport(worldVector(vect(0, 0, 5), eventPlayer, Transform.ROTATION_AND_TRANSLATION))
*/
/*
rule "debug humans win":
	@Event eachPlayer
	@Condition eventPlayer.isHoldingButton(Button.INTERACT)
    roundWinners = TEAM_HUMANS
*/

/*
rule "(debug) print coords":
	@Event global
	@Condition ENABLE_DEBUG
    hudHeader(getAllPlayers(), hostPlayer.getPosition(), HudPosition.LEFT, 0, Color.GREEN, HudReeval.VISIBILITY_AND_STRING)
    hudHeader(getAllPlayers(), distance(hostPlayer.getPosition(), sectionSpawns[currentSection + 1]), HudPosition.LEFT, 0, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING)
    print(hostPlayer.isFiringSecondaryFire())

    
rule "pharah debug":
	@Event eachPlayer
	@Condition ENABLE_DEBUG and eventPlayer.isCommunicating(Comms.NEED_HEALING) and eventPlayer.getCurrentHero() == Hero.PHARAH
    destroyAllEffects()
    wait(1)
    currentSection++
    sectionLoopIndex = 0
*/

rule "spawn dummies":
	@Event global
	@Condition ADD_DUMMIES
    createDummy(Hero.ANA, Team.ALL, -1, hostPlayer.getPosition(), vect(0,0,0))
    createDummy(Hero.ASHE, Team.ALL, -1, hostPlayer.getPosition(), vect(0,0,0))
    createDummy(Hero.BAPTISTE, Team.ALL, -1, hostPlayer.getPosition(), vect(0,0,0))

rule "tp dummies":
	@Event global
	@Condition ADD_DUMMIES and hostPlayer.isCommunicating(Comms.VOICE_LINE_UP)
    [player for player in getAllPlayers() if player != hostPlayer].teleport(hostPlayer.getPosition())

rule "tp dummies to current point":
    @Event global
    @Condition ADD_DUMMIES and hostPlayer.isCommunicating(Comms.ULTIMATE_STATUS)
    [player for player in getAllPlayers() if player != hostPlayer and player.team == TEAM_HUMANS].teleport(triggers[currentSection])

rule "dummy hit":
	@Event global
	@Condition ADD_DUMMIES and hostPlayer.isHoldingButton(Button.RELOAD)
    [player for player in getAllPlayers() if player != hostPlayer].forceButtonPress(Button.PRIMARY_FIRE)

