namespace Trainer
{
	class EffectCheat : Cheat
	{
		array<IEffect@>@ m_effects;
		float m_intensity;

		EffectCheat(UnitPtr unit, SValue &params)
		{
			super(unit, params);

			@m_effects = LoadEffects(unit, params);
			m_intensity = GetParamFloat(unit, params, "intensity", false, 1.0f);

			m_type = CheatType::Action;
		}

		void OnClicked() override
		{
			auto player = GetLocalPlayer();
			if (player is null)
				return;

			vec2 pos = xy(player.m_unit.GetPosition());
			ApplyEffects(m_effects, player, player.m_unit, pos, vec2(), m_intensity, false);

			//PlaySound2D(Resources::GetSoundEvent(""));
		}
	}
}
