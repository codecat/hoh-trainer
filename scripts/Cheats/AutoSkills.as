namespace Trainer
{
	class AutoSkills : Cheat
	{
		AutoSkills(UnitPtr unit, SValue &params)
		{
			super(unit, params);
		}

		void Update(int dt) override
		{
			if (!m_enabled)
				return;

			auto input = GetInput();
			if (input is null)
				return;

			input.Attack4.Pressed = input.Attack4.Down;
			input.Attack3.Pressed = input.Attack3.Down;
			input.Attack2.Pressed = input.Attack2.Down;
		}
	}
}
