#current code: 3AZ61

#!define ENABLE_DEBUG false
#!define ADD_DUMMIES false
#!define ENABLE_WALL_KB true
#!define ENABLE_FIRST_INFECTION true
#!define ZE_VERSION "5.2.0"

#!include "settings.opy"

#Global variables

globalvar currentSectionWalls
globalvar tpStarts
globalvar tpDests
globalvar deathplaneY
globalvar roundWinners
globalvar hasFirstInfectionPassed
globalvar currentBossFight
globalvar sectionLoopIndex
globalvar level
globalvar allPlayersIfZombiesWin
globalvar allPlayersIfHumansWin

globalvar arenaBottomRight
globalvar arenaBottomLeft
globalvar arenaTopLeft
globalvar arenaLeftRightVect
globalvar arenaBottomTopVect
globalvar arenaLeftRightVectSpace
globalvar arenaLeftRightNbBeams
globalvar arenaBottomTopVectSpace
globalvar arenaBottomTopNbBeams
globalvar bossSpawn
globalvar bossFightHero
globalvar bossFightZombieDeathplane
globalvar bossPlayer
globalvar arenaWallIndexLeftRight
globalvar arenaWallIndexBottomTop
globalvar arenaLeftRightCrossThreshold
globalvar arenaBottomTopCrossThreshold
globalvar arenaLeftRightCrossDiff
globalvar arenaBottomTopCrossDiff
globalvar bossFightType
globalvar bossSpawnEffect
globalvar arenaFloor
globalvar arenaCeiling
globalvar arenaWallIndex
globalvar bossFightHealthHud

globalvar sectionSpawns
globalvar sectionRadiuses
globalvar currentSection
globalvar firstInfectionTimer
globalvar matchTime
globalvar countdownStatus
globalvar roundStatus
globalvar triggers
globalvar walls
globalvar debugVar
globalvar firstInfectionHud
globalvar sectionHoldTimes
globalvar sectionWallStarts
globalvar sectionWallLengths
globalvar antiCrashActivated

globalvar createWinTextHuds
globalvar displayZombiesWinText
globalvar displayHumansWinText

globalvar addExtraDummy
globalvar extraDummy
globalvar extraDummyHero
globalvar extraDummyHp
globalvar extraDummyMaxHp
globalvar extraDummyPosition
globalvar extraDummySlot
globalvar cannotPutExtraDummyHud

globalvar integrityCheckFailed1
globalvar integrityCheckFailed2
globalvar integrityCheckFailed3
globalvar integrityCheckFailed4
globalvar integrityCheckFailed5

#Player variables

playervar fastFireCountdown
playervar tempPos
playervar currentHero
playervar isHealedByAna
playervar hasWonRound
playervar tempHero
playervar wallLoopIndex
playervar zenCharge
playervar wasFirstZombieLastRound
playervar soldierHealPosition
playervar team
playervar sombraSphere
playervar sombraSphereRadius
playervar tempPos2

#Subroutines

subroutine displayCredit

#Other

#!define GAME_NOT_STARTED 0
#!define NEW_ROUND 1
#!define IS_ASSEMBLING_HEROES 2
#!define GAME_IN_PROGRESS 3

#!define NO_COUNTDOWN 0
#!define FIRST_COUNTDOWN 1
#!define SECOND_COUNTDOWN 2
#!define TP_COUNTDOWN 3
#!define COUNTDOWN_FINISHED 4

#!define NO_TEAM 0
#!define TEAM_HUMANS 1
#!define TEAM_ZOMBIES 2
#!define TEAM_BOSS 3

#!define NO_BOSS_FIGHT 0
#!define BOSS_FIGHT_DORADO 1

#!define humanHeroes [Hero.ANA, Hero.ASHE, Hero.BASTION, Hero.BAPTISTE, Hero.ECHO, Hero.HANZO, Hero.JUNKRAT, Hero.MCCREE, Hero.MOIRA, Hero.PHARAH, Hero.REAPER, Hero.SOLDIER, Hero.SOMBRA, Hero.TRACER, Hero.WIDOWMAKER, Hero.ZARYA, Hero.ZENYATTA]
#!define zombieHeroes [Hero.TORBJORN, Hero.REINHARDT, Hero.WINSTON, Hero.BRIGITTE]

#!define kbMult 1.3
#!define kbScalar 0.2
#!define kbMultScalar (kbMult*(1-kbScalar))
#!define kbRatioMult (kbMult*kbScalar)

#!define generateArenaVectors(bottomRight, bottomLeft, topLeft) __script__("GenerateArenaVectors.js")
#!define getHumans() [player for player in getAllPlayers() if player.team == TEAM_HUMANS]
#!define getZombies() [player for player in getAllPlayers() if player.team == TEAM_ZOMBIES]
#!define generateMapData(mapData) __script__("GenerateMapData.js")

#!obfuscate

#!include "maps/KingsRow.opy"
#!include "maps/Eichenwalde.opy"
#!include "maps/BlizzardWorld.opy"
#!include "maps/OasisCityCenter.opy"
#!include "maps/Dorado.opy"

rule "integrity check 1":
	@Event eachPlayer
	@Condition roundStatus == GAME_IN_PROGRESS and eventPlayer.team == TEAM_HUMANS and not (eventPlayer.getCurrentHero() in humanHeroes)
    do:
        if not integrityCheckFailed1:
            integrityCheckFailed1 = true
            wait(random.randint(10, 15))
        hudHeader(getAllPlayers(), "This gamemode is a knockoff! Get the real one at workshop.elohell.gg/zombie", HudPosition.TOP, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)
        wait()
    while true

#!include "heroes/Ana.opy"
#!include "heroes/Baptiste.opy"
#!include "heroes/Hanzo.opy"
#!include "heroes/Soldier.opy"
#!include "heroes/Sombra.opy"
#!include "heroes/Widowmaker.opy"
#!include "heroes/Zenyatta.opy"

rule "integrity check 2":
	@Event eachPlayer
	@Condition roundStatus == GAME_IN_PROGRESS and eventPlayer.team == TEAM_HUMANS and not (eventPlayer.getCurrentHero() in humanHeroes)
    do:
        if not integrityCheckFailed2:
            integrityCheckFailed2 = true
            wait(random.randint(10, 15))
        destroyAllEffects()
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(0,-1000,0), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        wait()
    while true

#!include "Teams.opy"
#!include "Debug.opy"
#!include "BossFight.opy"
#!include "ExtraDummy.opy"
#!include "GameEnd.opy"


rule "initial zombie hero + other vars":
	@Event global

    hudHeader(getAllPlayers(), "Waiting for players to start ... ({} / 6)".format(len(getAllPlayers())), HudPosition.TOP, -10, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubtext(getAllPlayers(), "In the meantime, battle it out!\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", HudPosition.TOP, -9, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    displayCredit()
    currentSection = 0
    matchTime = 1200

    if ENABLE_DEBUG:
        level = 1

#debug((kbMultScalar+kbRatioMult*(len(getZombies())/len(getHumans()))))

def displayCredit():
    hudSubheader(getAllPlayers(), 
"ZE "ZE_VERSION" by Zezombye#9938 (discord)
workshop.elohell.gg/zombie | code: 3AZ61
load: {} avg: {} peak: {}".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()), HudPosition.LEFT, -300, Color.PURPLE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)

rule "assembling heroes":
	@Event global
	@Condition isAssemblingHeroes()
    destroyAllDummies()
    createWinTextHuds = false
    displayZombiesWinText = false
    displayHumansWinText = false
    if not ENABLE_DEBUG:
        destroyAllHudTexts()
    destroyAllInWorldText()
    setMatchTime(9)
    roundStatus = IS_ASSEMBLING_HEROES
    allPlayersIfHumansWin = null
    allPlayersIfZombiesWin = null

    hasFirstInfectionPassed = false
    currentBossFight = NO_BOSS_FIGHT
    currentSection = 0
    stopChasingVariable(firstInfectionTimer)
    firstInfectionTimer = 0
    countdownStatus = NO_COUNTDOWN
    roundWinners = NO_TEAM
    bossPlayer = null
    arenaWallIndex = arenaFloor

    #Add huds so that top huds act as "big message"
    hudSubtext(getAllPlayers(), " \n\n\n", HudPosition.TOP, 1, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.ALWAYS)

    #Credit
    displayCredit()

    getAllPlayers().hasWonRound = 0
    getAllPlayers().team = NO_TEAM

    getAllPlayers().setAllowedHeroes(humanHeroes)
    getAllPlayers().stopForcingCurrentHero()
    disableGamemodeCompletion()

    if ADD_DUMMIES:
        createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
        createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
        createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))

    wait(5)
    createWinTextHuds = true

    
rule "init new round":
	@Event global
	@Condition roundStatus == NEW_ROUND and getMatchTime() != 0
    matchTime = getMatchTime()
        
    wait(0.25)
    goToAssembleHeroes()
    wait(5)
    destroyAllEffects()


rule "start game if 6 players":
	@Event global
	@Condition len(getAllPlayers()) >= 6 and roundStatus == GAME_NOT_STARTED and not ENABLE_DEBUG
    smallMessage(getAllPlayers(), "Starting game in 5 seconds")
    wait(1)
    smallMessage(getAllPlayers(), "Starting game in 4 seconds")
    wait(1)
    smallMessage(getAllPlayers(), "Starting game in 3 seconds")
    wait(1)
    smallMessage(getAllPlayers(), "Starting game in 2 seconds")
    wait(1)
    smallMessage(getAllPlayers(), "Starting game in 1 second")
    wait(1)
    #Fill up the lobby to trigger game start
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))
    createDummy(Hero.ANA, Team.ALL, -1, vect(1000,0,1000), vect(0,0,0))

    
rule "destroy bugged dummies?":
    @Event eachPlayer
    @Condition roundStatus == GAME_IN_PROGRESS
    @Condition eventPlayer.isDummy()
    @Condition not ADD_DUMMIES
    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())


rule "round start":
	@Event global
	@Condition isGameInProgress()
    roundStatus = GAME_IN_PROGRESS
    setMatchTime(matchTime)
    sectionLoopIndex = 0


rule "init section (slice + draw tp + trigger)":
	@Event global
	@Condition sectionLoopIndex == 0 and roundStatus >= GAME_IN_PROGRESS
    currentSectionWalls = walls.slice(sectionWallStarts[currentSection], sectionWallLengths[currentSection])
    createEffect(getAllPlayers(), Effect.ORB, Color.GREEN, tpStarts[currentSection], 0.25, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    #Draw trigger
    destroyAllIcons()
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, triggers[currentSection], 4, EffectReeval.VISIBILITY)
    createIcon(getAllPlayers(), triggers[currentSection], Icon.ARROW_DOWN, IconReeval.VISIBILITY_AND_POSITION, Color.BLUE, true)

    if ENABLE_DEBUG and sectionHoldTimes[currentSection] > 0:
        sectionHoldTimes[currentSection] = 10
    
rule "walls visual effect":
	@Event global
	@Condition sectionLoopIndex == 0
    do:
        createEffect(getAllPlayers(), Effect.SPHERE, Color.ORANGE, currentSectionWalls[sectionLoopIndex], 4, EffectReeval.VISIBILITY)
        createEffect(getAllPlayers(), Effect.SPHERE, Color.ORANGE, currentSectionWalls[sectionLoopIndex] + vect(0, 4, 0), 4, EffectReeval.VISIBILITY)
        sectionLoopIndex++
        wait(0.05)
    while sectionLoopIndex < len(currentSectionWalls)

rule "walls kb effect":
	@Event eachPlayer
	@Condition ENABLE_WALL_KB
    do:
        if eventPlayer.getPosition().y < currentSectionWalls[eventPlayer.wallLoopIndex].y - 4:
            goto lbl_0
        if distance(vect(eventPlayer.getPosition().x, 0, eventPlayer.getPosition().z), vect(currentSectionWalls[eventPlayer.wallLoopIndex].x, 0, currentSectionWalls[eventPlayer.wallLoopIndex].z)) > 4.5:
            goto lbl_1
        eventPlayer.setStatusEffect(null, Status.ROOTED, 0.048)
        eventPlayer.applyImpulse(Vector.UP, 1, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        eventPlayer.applyImpulse(vect(vectorTowards(currentSectionWalls[eventPlayer.wallLoopIndex], eventPlayer.getPosition()).x, 0, vectorTowards(currentSectionWalls[eventPlayer.wallLoopIndex], eventPlayer.getPosition()).z), 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        lbl_0:
        lbl_1:
        eventPlayer.wallLoopIndex++
        if eventPlayer.wallLoopIndex < len(currentSectionWalls):
            goto lbl_3
        eventPlayer.wallLoopIndex = 0
        lbl_3:
        wait(0.016)
    while true


rule "use tp":
	@Event eachPlayer
	@Condition distance(eventPlayer.getPosition(), tpStarts[currentSection] - vect(0, 1, 0)) < 2
    eventPlayer.teleport(tpDests[currentSection])


rule "trigger":
	@Event global
	@Condition len(getPlayersInRadius(triggers[currentSection], 5, Team.ALL, LosCheck.OFF)) > 0 and countdownStatus == NO_COUNTDOWN and currentBossFight == NO_BOSS_FIGHT

    #In case the player spawns into the trigger (can happen with FFA spawns)
    wait(0.15, Wait.ABORT_WHEN_FALSE)

    #Immediately end the game if there are zombies
    if len([player for player in getPlayersInRadius(triggers[currentSection], 5, Team.ALL, LosCheck.OFF) if player.team == TEAM_ZOMBIES]) != 0:
        roundWinners = TEAM_ZOMBIES
        return
    
    #Check if it is the last section
    if currentSection == len(sectionHoldTimes)-1:
        roundWinners = TEAM_HUMANS
        return

    #Don't do anything if the current trigger is a boss fight (defined as time == -1)
    if sectionHoldTimes[currentSection] == -1:
        currentBossFight = bossFightType
        return
        
    bigMessage(getAllPlayers(), "Defend: {} seconds".format(sectionHoldTimes[currentSection]))
    countdownStatus = FIRST_COUNTDOWN
    wait(sectionHoldTimes[currentSection] - 8)
    if roundStatus <= IS_ASSEMBLING_HEROES:
        return
    
    bigMessage(getAllPlayers(), "Defend: 8 seconds")
    #smallMessage([player for player in getPlayersInRadius(triggers[currentSection], sectionRadiuses[currentSection], Team.ALL, LosCheck.OFF) if player.team == TEAM_HUMANS], "2 far! Go blue sphere!")
    countdownStatus = SECOND_COUNTDOWN
    wait(6)

    createBeam(getAllPlayers(), Beam.BAD, sectionSpawns[currentSection+1]+vect(0.7+0.01, -1000, 0.7), sectionSpawns[currentSection+1]+vect(0.7, 1000, 0.7), Color.RED, EffectReeval.VISIBILITY)
    #smallMessage([player for player in getPlayersInRadius(triggers[currentSection], sectionRadiuses[currentSection], Team.ALL, LosCheck.OFF) if player.team == TEAM_HUMANS], "2 far! Go blue sphere!")
    wait(0.5)
    createBeam(getAllPlayers(), Beam.BAD, sectionSpawns[currentSection+1]+vect(0.7+0.01, -1000, -0.7), sectionSpawns[currentSection+1]+vect(0.7, 1000, -0.7), Color.RED, EffectReeval.VISIBILITY)
    #smallMessage([player for player in getPlayersInRadius(triggers[currentSection], sectionRadiuses[currentSection], Team.ALL, LosCheck.OFF) if player.team == TEAM_HUMANS], "2 far! Go blue sphere!")
    wait(0.5)
    createBeam(getAllPlayers(), Beam.BAD, sectionSpawns[currentSection+1]+vect(-0.7+0.01, -1000, 0), sectionSpawns[currentSection+1]+vect(-0.7, 1000, 0), Color.RED, EffectReeval.VISIBILITY)
    #smallMessage([player for player in getPlayersInRadius(triggers[currentSection], sectionRadiuses[currentSection], Team.ALL, LosCheck.OFF) if player.team == TEAM_HUMANS], "2 far! Go blue sphere!")
    wait(0.5)
    if roundStatus <= IS_ASSEMBLING_HEROES:
        return
    
    #bigMessage(getAllPlayers(), "Defend: 1 Sec")
    countdownStatus = TP_COUNTDOWN
    wait(0.5)
    if roundStatus <= IS_ASSEMBLING_HEROES:
        return
    
    countdownStatus = NO_COUNTDOWN
    currentSection++
    bigMessage(getAllPlayers(), "Run!!!")
    destroyAllEffects()
    wait(0.05)
    sectionLoopIndex = 0

    #In case the next trigger is at the same position
    __loopIfConditionIsTrue__()


rule "first infection timer":
	@Event global
	@Condition ENABLE_FIRST_INFECTION and roundStatus == GAME_IN_PROGRESS

    #Display "First infection in x seconds" cooldown
    hudSubtext(getAllPlayers(), "First infection in {} {}.".format(max(ceil(10-firstInfectionTimer), 1), "seconds" if firstInfectionTimer < 9 else "second"), HudPosition.TOP, 10, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.ALWAYS)

    
    firstInfectionHud = getLastCreatedText()
    chase(firstInfectionTimer, 20, rate=1, ChaseReeval.NONE)

rule "first infection":
	@Event global
	@Condition ENABLE_FIRST_INFECTION and roundStatus == GAME_IN_PROGRESS and firstInfectionTimer > 10

    destroyHudText(firstInfectionHud)
    stopChasingVariable(firstInfectionTimer)
    #First infection: 2 zombies if more than 9 players, else 1
    random.shuffle([player for player in getAllPlayers() if player.hasSpawned() and player.wasFirstZombieLastRound == 0]).slice(0, 1+(len(getHumans()) > 9)).team = TEAM_ZOMBIES

    hasFirstInfectionPassed = true
    getZombies().teleport(sectionSpawns[0])
    getZombies().wasFirstZombieLastRound = 1

    getHumans().wasFirstZombieLastRound = 0


rule "tp players at 1 sec left":
	@Event eachPlayer
	@Condition countdownStatus == TP_COUNTDOWN and not(eventPlayer in getPlayersInRadius(triggers[currentSection], sectionRadiuses[currentSection], Team.ALL, LosCheck.OFF))
    eventPlayer.teleport(sectionSpawns[currentSection+1])


rule "deathplane tp":
	@Event eachPlayer
	@Condition eventPlayer.getPosition().y < deathplaneY and roundStatus != GAME_NOT_STARTED and roundWinners == NO_TEAM
    eventPlayer.teleport(sectionSpawns[currentSection])
    eventPlayer.resurrect()


rule "infect players":
	@Event playerTookDamage
	@Condition attacker.team == TEAM_ZOMBIES and victim.team == TEAM_HUMANS and roundWinners == NO_TEAM and distance(attacker.getPosition(), victim.getPosition()) <= 5.5
    #attacker.addToScore(1)
    kill(victim, attacker)
    wait(0.016)
    victim.team = TEAM_ZOMBIES
    victim.resurrect()

rule "no more humans = zombies win":
	@Event global
	@Condition roundWinners == NO_TEAM and roundStatus >= GAME_IN_PROGRESS and hasFirstInfectionPassed and len(getHumans()) == 0
    roundWinners = TEAM_ZOMBIES


rule "player dies = gets tp'd, +10 pts if zombie kill":
	@Event playerDied
	@Condition roundWinners == NO_TEAM and roundStatus != GAME_NOT_STARTED
    if attacker.team != TEAM_ZOMBIES or victim.team != TEAM_HUMANS:
        victim.resurrect()
        victim.teleport(sectionSpawns[currentSection])

    if attacker.team != TEAM_ZOMBIES:
        attacker.addToScore(9)
    
    if attacker.team == TEAM_BOSS:
        victim.team = TEAM_ZOMBIES


rule "damage modifications":
	@Event global
    @Condition isGameInProgress()
    #Zombies can't hurt each other.
    startDamageModification(getZombies(), getZombies(), 0, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        #Stack damage modifications to get around the unnecessary limit and to counteract the damage reduction needed for cars to deal 40 dmg
        startDamageModification(getZombies(), getHumans(), 10000, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        startDamageModification(getZombies(), getHumans(), 10000, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        startDamageModification(getZombies(), getHumans(), 10000, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        startDamageModification(getZombies(), getHumans(), 10000, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        startDamageModification(getZombies(), getHumans(), 10000, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
        startDamageModification(getZombies(), getHumans(), 250, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)

        #Humans can't hurt each other, but allow a little damage to get through, to detect healing.
        startDamageModification(getHumans(), getHumans(), 3, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)
    else:
        startDamageModification(getHumans(), getHumans(), 0.0003, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)


rule "humans and zombies can hurt each other + kb":
	@Event playerDealtDamage
	@Condition attacker.team != victim.team and victim.team == TEAM_ZOMBIES

    #Randomly apply upwards impulse (more kb)
    if random.randint(1, 6) == 1:
        victim.applyImpulse(Vector.UP, 1.0, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    
    victim.applyImpulse(vect(vectorTowards(attacker.getPosition(), victim.getPosition()).x, 0, vectorTowards(attacker.getPosition(), victim.getPosition()).z), eventDamage*(kbMultScalar+kbRatioMult*(len(getZombies())/len(getHumans()))), Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "player selected hero: change to human":
	@Event eachPlayer
	@Condition eventPlayer.hasSpawned() and roundStatus >= GAME_IN_PROGRESS
    eventPlayer.disallowButton(Button.CROUCH)
    if hasFirstInfectionPassed:
        eventPlayer.team = TEAM_ZOMBIES
    else:
        eventPlayer.team = TEAM_HUMANS
    
    wait(0.1)
    eventPlayer.teleport(sectionSpawns[currentSection])
    wait(2)
    eventPlayer.allowButton(Button.CROUCH)


rule "burn = slow":
	@Event eachPlayer
	@Condition eventPlayer.team == TEAM_ZOMBIES and eventPlayer.hasStatusEffect(Status.BURNING)
    eventPlayer.setMoveSpeed(75)

rule "back to normal speed":
	@Event eachPlayer
	@Condition eventPlayer.team == TEAM_ZOMBIES and not eventPlayer.hasStatusEffect(Status.BURNING) and not eventPlayer.hasStatusEffect(Status.HACKED)
    eventPlayer.setMoveSpeed(100)

rule "hack = slow":
	@Event eachPlayer
	@Condition eventPlayer.team == TEAM_ZOMBIES and eventPlayer.hasStatusEffect(Status.HACKED)
    eventPlayer.setMoveSpeed(70)


/*rule "no hax for humans":
	@Event eachPlayer
	@Condition eventPlayer.hasStatusEffect(Status.HACKED) and eventPlayer.team == TEAM_HUMANS
    eventPlayer.clearStatusEffect(Status.HACKED)*/


rule "no stun for humans":
	@Event eachPlayer
	@Condition eventPlayer.hasStatusEffect(Status.STUNNED) and eventPlayer.team == TEAM_HUMANS
    eventPlayer.clearStatusEffect(Status.STUNNED)


rule "no junk trap for humans":
	@Event playerTookDamage
    @Condition attacker.getCurrentHero() == Hero.JUNKRAT and victim.team == TEAM_HUMANS
    victim.tempPos2 = eventPlayer.getPosition()
    victim.teleport(eventPlayer.tempPos2+vect(0,1000,0))
    wait()
    victim.teleport(eventPlayer.tempPos2)
    


rule "red orb":
	@Event global
	@Condition countdownStatus == SECOND_COUNTDOWN
    createEffect(getAllPlayers(), Effect.ORB, Color.RED, sectionSpawns[currentSection + 1], 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)


rule "map finished":
	@Event global
	@Condition level >= 3
    declarePlayerVictory(sorted(getAllPlayers(), key=lambda player: player.getScore()).last())

rule "zombies win":
	@Event global
	@Condition roundWinners == TEAM_ZOMBIES
    #bigMessage(getAllPlayers(), "Zombies win")
    displayZombiesWinText = true
    wait(0.35)
    setSlowMotion(50)
    wait(2.5)
    #stopAllDamageModifications()
    setSlowMotion(100)
    if getMatchTime() == 0:
        level = 4
        return
    roundStatus = NEW_ROUND


rule "humans win":
	@Event global
	@Condition roundWinners == TEAM_HUMANS
    #bigMessage(getAllPlayers(), "Humans win")
    displayHumansWinText = true
    #stopAllDamageModifications()
    wait(0.1)
    kill(getZombies(), null)
    kill(getZombies(), null) #make damn sure these mfs are dead
    wait(0.25)
    setSlowMotion(50)
    wait(1.5)
    if level == 1:
        smallMessage(getAllPlayers(), "Final Level: {}".format(zombieHeroes[level + 1]))
    elif level < 2:
        smallMessage(getAllPlayers(), "Level {}: {}".format(level + 2, zombieHeroes[level + 1]))
    setSlowMotion(30)
    wait(1.5)
    setSlowMotion(100)
    wait(0.5)
    getHumans().addToScore(100)

    level++
    setMatchTime(1200)
    roundStatus = NEW_ROUND


rule "skirmish rez":
	@Event playerDied
	@Condition getMatchTime() == 0 and roundStatus == GAME_NOT_STARTED
    wait(4)
    victim.respawn()


rule "anti crash":
	@Event global
	@Condition not antiCrashActivated and getServerLoad() > 200
    wait(1, Wait.ABORT_WHEN_FALSE)
    smallMessage(getAllPlayers(), "Anti crash system activated")
    setSlowMotion(10)
    antiCrashActivated = true

rule "disable anti crash":
	@Event global
	@Condition antiCrashActivated and getServerLoad() < 175
    setSlowMotion(100)
    antiCrashActivated = false
