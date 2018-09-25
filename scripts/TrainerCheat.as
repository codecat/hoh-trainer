namespace Trainer
{
	enum CheatType
	{
		Togglable,
		Action,
	}

	class Cheat
	{
		string m_id;
		string m_name;
		string m_description;

		CheatType m_type = CheatType::Togglable;

		bool m_enabled;

		Cheat(UnitPtr unit, SValue& params)
		{
			m_id = GetParamString(unit, params, "id");
			m_name = GetParamString(unit, params, "name");
			m_description = GetParamString(unit, params, "description", false);

			m_enabled = GetParamBool(unit, params, "enabled", false, false);
		}

		void SetEnabled(bool enabled)
		{
			if (m_enabled == enabled)
				return;

			m_enabled = enabled;
			if (m_enabled)
				OnEnabled();
			else
				OnDisabled();
		}

		void Update(int dt) { }

		void OnEnabled() { }
		void OnDisabled() { }
		void OnClicked() { }

		void Save(SValueBuilder &builder)
		{
			builder.PushBoolean("enabled", m_enabled);
		}

		void Load(SValue@ params)
		{
			SetEnabled(GetParamBool(UnitPtr(), params, "enabled"));
		}
	}
}
