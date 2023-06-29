#!mainFile "../ZombieEscape.opy"

rule "no climb on walls":
	@Event eachPlayer
	@Hero hanzo
	@Condition eventPlayer.isOnWall()
    #eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 0.016)
    eventPlayer.cancelPrimaryAction()
    eventPlayer.applyImpulse(Vector.DOWN, 10, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
