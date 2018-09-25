namespace Trainer
{
	class NoSkillCooldown : Cheat
	{
		NoSkillCooldown(UnitPtr unit, SValue& params)
		{
			super(unit, params);
		}

		void Update(int dt) override
		{
			if (!m_enabled)
				return;

			auto player = GetLocalPlayer();
			if (player is null)
				return;

			for (uint i = 0; i < player.m_skills.length(); i++)
			{
				auto activeSkill = cast<Skills::ActiveSkill>(player.m_skills[i]);
				if (activeSkill !is null)
				{
					activeSkill.m_cooldownC = 0;

					if (activeSkill.m_castingC > 0)
						activeSkill.m_castingC = 1;
				}
			}
		}
	}
}
