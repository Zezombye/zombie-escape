#!mainFile "zombieescape.opy"

rule "boss fight kb left/right":
	@Event eachPlayer
	@Condition currentBossFight != NO_BOSS_FIGHT and eventPlayer.team != TEAM_ZOMBIES and abs(crossProduct(arenaBottomTopVect, eventPlayer.getPosition()).y - arenaLeftRightCrossDiff) > arenaLeftRightCrossThreshold
    do:
        eventPlayer.setStatusEffect(null, Status.ROOTED, 0.016)
        eventPlayer.applyImpulse(arenaLeftRightVect*getSign(crossProduct(arenaBottomTopVect, eventPlayer.getPosition()).y - arenaLeftRightCrossDiff), 5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        wait(0.016)
    while RULE_CONDITION

rule "boss fight kb bottom/top":
	@Event eachPlayer
	@Condition currentBossFight != NO_BOSS_FIGHT and eventPlayer.team != TEAM_ZOMBIES and abs(crossProduct(arenaLeftRightVect, eventPlayer.getPosition()).y - arenaBottomTopCrossDiff) > arenaBottomTopCrossThreshold
    do:
        eventPlayer.setStatusEffect(null, Status.ROOTED, 0.016)
        eventPlayer.applyImpulse(arenaBottomTopVect*(0-getSign(crossProduct(arenaBottomTopVect, eventPlayer.getPosition()).y - arenaBottomTopCrossDiff)), 5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        wait(0.016)
    while RULE_CONDITION

rule "boss fight init":
	@Event global
	@Condition currentBossFight != NO_BOSS_FIGHT

    destroyAllEffects()
    destroyAllIcons()
    wait(0.2)
    createEffect(getAllPlayers(), Effect.BAD_AURA, Color.RED, bossSpawn, 4, EffectReeval.VISIBILITY)
    bossSpawnEffect = getLastCreatedEntity()
    bigMessage(getAllPlayers(), "Boss Incoming!")
    wait(3)
    if len(getZombies()) == 0:
        return
    bossPlayer = random.choice(getZombies())
    destroyEffect(bossSpawnEffect)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.RED, bossSpawn, 5)
    #debug(crossProduct(arenaLeftRightVect, hostPlayer.getPosition()))
    #debug(crossProduct(arenaBottomTopVect, hostPlayer.getPosition()))

/*
rule "boss fight display walls left/right":
	@Event global
	@Condition currentBossFight != NO_BOSS_FIGHT
    do:
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaBottomLeft+arenaLeftRightVectSpace*arenaWallIndexLeftRight+vect(0.01, 1000, 0), arenaBottomLeft+arenaLeftRightVectSpace*arenaWallIndexLeftRight+vect(0, -1000, 0), Color.WHITE, EffectReeval.VISIBILITY)
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaTopLeft+arenaLeftRightVectSpace*arenaWallIndexLeftRight+vect(0.01, 1000, 0), arenaTopLeft+arenaLeftRightVectSpace*arenaWallIndexLeftRight+vect(0, -1000, 0), Color.WHITE, EffectReeval.VISIBILITY)
        arenaWallIndexLeftRight++
        wait(0.016)
    while arenaWallIndexLeftRight < arenaLeftRightNbBeams
    arenaWallIndexLeftRight = 0

rule "boss fight display walls bottom/top":
	@Event global
	@Condition currentBossFight != NO_BOSS_FIGHT
    do:
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaBottomLeft+arenaBottomTopVectSpace*arenaWallIndexBottomTop+vect(0.01, 1000, 0), arenaBottomLeft+arenaBottomTopVectSpace*arenaWallIndexBottomTop+vect(0, -1000, 0), Color.WHITE, EffectReeval.VISIBILITY)
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaBottomRight+arenaBottomTopVectSpace*arenaWallIndexBottomTop+vect(0.01, 1000, 0), arenaBottomRight+arenaBottomTopVectSpace*arenaWallIndexBottomTop+vect(0, -1000, 0), Color.WHITE, EffectReeval.VISIBILITY)
        arenaWallIndexBottomTop++
        wait(0.016)
    while arenaWallIndexBottomTop < arenaBottomTopNbBeams
    arenaWallIndexBottomTop = 0

*/

rule "boss fight display walls":
	@Event global
	@Condition currentBossFight != NO_BOSS_FIGHT
    do:
        #top beam
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaTopLeft+vect(0, arenaWallIndex, 0), arenaTopLeft+arenaLeftRightVect+vect(0, arenaWallIndex, 0), Color.WHITE, EffectReeval.VISIBILITY)
        #right beam
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaBottomRight+vect(0, arenaWallIndex, 0), arenaBottomRight+arenaBottomTopVect+vect(0, arenaWallIndex, 0), Color.WHITE, EffectReeval.VISIBILITY)
        #bottom beam
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaBottomLeft+vect(0, arenaWallIndex, 0), arenaBottomRight+vect(0, arenaWallIndex, 0), Color.WHITE, EffectReeval.VISIBILITY)
        #left beam
        createBeam(getAllPlayers(), Beam.GRAPPLE, arenaBottomLeft+vect(0, arenaWallIndex, 0), arenaTopLeft+vect(0, arenaWallIndex, 0), Color.WHITE, EffectReeval.VISIBILITY)
        arenaWallIndex++
        wait(0.016)
    while arenaWallIndex < arenaCeiling
    arenaWallIndex = arenaFloor


rule "boss fight player":
	@Event eachPlayer
	@Condition eventPlayer == bossPlayer
    eventPlayer.startForcingHero(bossFightHero)
    eventPlayer.team = TEAM_BOSS
    eventPlayer.teleport(bossSpawn)
    createInWorldText(getAllPlayers(), [
        "■□□□□□□□□□",
        "■■□□□□□□□□",
        "■■■□□□□□□□",
        "■■■■□□□□□□",
        "■■■■■□□□□□",
        "■■■■■■□□□□",
        "■■■■■■■□□□",
        "■■■■■■■■□□",
        "■■■■■■■■■□",
        "■■■■■■■■■■",
    ][floor(bossPlayer.getHealth()/(bossPlayer.getMaxHealth()+1)*10)], bossPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.ALWAYS)
    bossFightHealthHud = getLastCreatedText()

rule "boss dies":
	@Event playerDied
	@Condition victim == bossPlayer
    victim.team = TEAM_ZOMBIES
    bossPlayer = null
    destroyInWorldText(bossFightHealthHud)

rule "no more boss":
	@Event global
	@Condition currentBossFight != NO_BOSS_FIGHT and len([player for player in getAllPlayers() if player.team == TEAM_BOSS]) == 0
    wait(3.5, Wait.ABORT_WHEN_FALSE)
    bigMessage(getAllPlayers(), "Boss Killed ...")
    wait(2)
    countdownStatus = NO_COUNTDOWN
    currentSection++
    bigMessage(getAllPlayers(), "Run!!!")
    destroyAllEffects()
    wait(0.05)
    sectionLoopIndex = 0
    wait(3)
    currentBossFight = NO_BOSS_FIGHT

rule "boss fight deathplane tp":
	@Event eachPlayer
	@Condition currentBossFight != NO_BOSS_FIGHT and eventPlayer.team == TEAM_ZOMBIES and eventPlayer.getPosition().y < bossFightZombieDeathplane
    eventPlayer.teleport(sectionSpawns[currentSection])
    eventPlayer.resurrect()

rule "dorado - boss ults":
	@Event eachPlayer
	@Condition eventPlayer == bossPlayer and eventPlayer.isHoldingButton(Button.ULTIMATE) and eventPlayer.getUltCharge() == 0 and currentBossFight == BOSS_FIGHT_DORADO
    eventPlayer.startFacing(eventPlayer.getFacingDirection(), 0, Relativity.TO_WORLD, FacingReeval.NONE)
    eventPlayer.setMoveSpeed(0)
    eventPlayer.applyImpulse(Vector.UP, 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(1)
    eventPlayer.applyImpulse(Vector.DOWN, 50, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    wait(0.5)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.stopFacing()

rule "dorado - boss charges":
	@Event eachPlayer
    @Condition currentBossFight == BOSS_FIGHT_DORADO and eventPlayer == bossPlayer and eventPlayer.isUsingAbility1()
    eventPlayer.setDamageDealt(66.6666)

    
rule "dorado - boss charges":
	@Event eachPlayer
    @Condition currentBossFight == BOSS_FIGHT_DORADO and eventPlayer == bossPlayer and not eventPlayer.isUsingAbility1()
    eventPlayer.setDamageDealt(100)