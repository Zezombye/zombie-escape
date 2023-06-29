#!mainFile "../ZombieEscape.opy"

rule "force ult if using winston":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.WINSTON
    @Condition eventPlayer.hasSpawned() and eventPlayer.isAlive()
    wait(1)
    eventPlayer.forceButtonPress(Button.ULTIMATE)