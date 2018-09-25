namespace Trainer
{
	class ModifierCheat : Cheat
	{
		array<Modifiers::Modifier@> m_modifiers;

		ModifierCheat(UnitPtr unit, SValue& params)
		{
			super(unit, params);

			m_modifiers = Modifiers::LoadModifiers(unit, params);
		}

		void OnEnabled() override
		{
			for (uint i = 0; i < m_modifiers.length(); i++)
				g_allModifiers.Add(m_modifiers[i]);
		}

		void OnDisabled() override
		{
			for (uint i = 0; i < m_modifiers.length(); i++)
				g_allModifiers.Remove(m_modifiers[i]);
		}
	}
}
