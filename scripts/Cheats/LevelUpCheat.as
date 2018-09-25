namespace Trainer
{
	class LevelUpCheat : Cheat
	{
		int m_amount;

		LevelUpCheat(UnitPtr unit, SValue &params)
		{
			super(unit, params);

			m_amount = GetParamInt(unit, params, "amount");

			m_type = CheatType::Action;
		}

		void OnClicked() override
		{
			auto record = GetLocalPlayerRecord();
			for (int i = 0; i < m_amount; i++)
			{
				int level = record.level;
				int xp = record.LevelExperience(level) - record.LevelExperience(level - 1);
				record.GiveExperience(xp);
			}
		}
	}
}
