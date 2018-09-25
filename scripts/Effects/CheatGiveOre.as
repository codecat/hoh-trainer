class CheatGiveOre : IEffect
{
	int m_amount;

	CheatGiveOre(UnitPtr unit, SValue& params)
	{
		m_amount = GetParamInt(unit, params, "amount");
	}

	void SetWeaponInformation(uint weapon) {}

	bool Apply(Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity, bool husk)
	{
		auto gm = cast<Campaign>(g_gameMode);
		if (cast<Town>(gm) !is null)
			gm.m_townLocal.m_ore += m_amount;
		else
			GiveOreImpl(m_amount, cast<Player>(target.GetScriptBehavior()));

		return true;
	}

	bool CanApply(Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity) override { return true; }
}
