#!mainFile "ZombieEscape.opy"

rule "player becomes dorado boss":
	@Event eachPlayer
	@Condition eventPlayer.team == TEAM_BOSS and currentBossFight == BOSS_FIGHT_DORADO
    
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setUltEnabled(true)
    eventPlayer.setDamageReceived(100)
    eventPlayer.setMoveSpeed(80)
    eventPlayer.setMaxHealth(500+200*len(getHumans()))
    wait(0.1)
    eventPlayer.startHoT(null, 2, 9999)

rule "player becomes zombie":
	@Event eachPlayer
	@Condition eventPlayer.team == TEAM_ZOMBIES
    eventPlayer.tempPos = eventPlayer.getPosition()
    eventPlayer.startForcingHero(zombieHeroes[level])
    eventPlayer.teleport(eventPlayer.tempPos)
    eventPlayer.stopAllHoT()
    eventPlayer.setStatusEffect(null, Status.ROOTED, 2)

    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(zombieHeroes[level] == Hero.TORBJORN)
    eventPlayer.setPrimaryFireEnabled(zombieHeroes[level] != Hero.WINSTON)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setUltEnabled(zombieHeroes[level] == Hero.WINSTON)
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.setKnockbackReceived(100)

    eventPlayer.setMoveSpeed(100)

    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        #A car deals 10M damage. Set damage to 4/1M (so 4/10000 %) to make cars deal 40 dmg.
        #Buff the players so that they deal 1/(4/10000)% damage.
        #kill() deals 1B damage, that is too little as zombies have more than 4k hp... Gotta do it twice omegalul.
        
        if zombieHeroes[level] == Hero.BRIGITTE:
            eventPlayer.setDamageReceived(70*(4/1000000))
            eventPlayer.setMaxHealth(1000)
        else:
            eventPlayer.setDamageReceived(50*(4/1000000))
            eventPlayer.setMaxHealth(500)
    else:
        if zombieHeroes[level] == Hero.BRIGITTE:
            eventPlayer.setDamageReceived(70)
            eventPlayer.setMaxHealth(1000)
        else:
            eventPlayer.setDamageReceived(50)
            eventPlayer.setMaxHealth(500)
    
    if len(getHumans()) > 0:
        bigMessage(eventPlayer, "Infected")
    wait(0.1)
    eventPlayer.startHoT(null, 2, 9999)
    wait(0.9)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    #eventPlayer.forceButtonPress(Button.ULTIMATE)

rule "player becomes human":
	@Event eachPlayer
	@Condition eventPlayer.team == TEAM_HUMANS
    eventPlayer.setAbility1Enabled(eventPlayer.getCurrentHero() in [Hero.BAPTISTE, Hero.BASTION, Hero.HANZO, Hero.JUNKRAT, Hero.MCCREE, Hero.SYMMETRA, Hero.ZARYA])
    eventPlayer.setAbility2Enabled(eventPlayer.getCurrentHero() in [Hero.ANA, Hero.ASHE, Hero.ECHO, Hero.HANZO, Hero.JUNKRAT, Hero.MCCREE, Hero.MOIRA, Hero.PHARAH, Hero.SOLDIER, Hero.TRACER, Hero.WIDOWMAKER, Hero.ZENYATTA])
    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(eventPlayer.getCurrentHero() in [Hero.ANA, Hero.ASHE, Hero.BASTION, Hero.ECHO, Hero.JUNKRAT, Hero.MCCREE, Hero.MOIRA, Hero.SOLDIER, Hero.WIDOWMAKER, Hero.ZARYA, Hero.ZENYATTA])
    eventPlayer.setUltEnabled(eventPlayer.getCurrentHero() in [Hero.ANA, Hero.BAPTISTE, Hero.BASTION, Hero.JUNKRAT, Hero.HANZO, Hero.MCCREE, Hero.MOIRA, Hero.PHARAH, Hero.REAPER, Hero.SOLDIER, Hero.SOMBRA, Hero.TRACER, Hero.WIDOWMAKER, Hero.ZARYA, Hero.ZENYATTA])
    eventPlayer.setKnockbackReceived(0)
    
    if eventPlayer.getCurrentHero() == Hero.SOMBRA:
        eventPlayer.disallowButton(Button.ULTIMATE)
    else:
        eventPlayer.allowButton(Button.ULTIMATE)
    
    eventPlayer.startForcingHero(eventPlayer.getCurrentHero())
    if getCurrentMap() == Map.OASIS_CITY_CENTER:
        eventPlayer.setDamageReceived(100*(4/1000000))
    else:
        eventPlayer.setDamageReceived(100)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.setMaxHealth(200)
    wait(0.1)
    eventPlayer.startHoT(null, 2, 9999)

