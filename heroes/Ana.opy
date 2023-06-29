#!mainFile "../ZombieEscape.opy"


rule "ana healing":
	@Event playerDealtDamage
	@Hero ana
	@Condition victim.team == TEAM_HUMANS and not victim.isHealedByAna
    victim.startHoT(attacker, 0.85, 40)
    victim.isHealedByAna = true
    wait(0.85)
    victim.isHealedByAna = false
