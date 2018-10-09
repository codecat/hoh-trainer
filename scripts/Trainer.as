namespace Trainer
{
	TrainerInterface@ g_interface;

	array<Cheat@> g_cheats;
	array<SValue@>@ g_savedCheats;

	void AddCheats(SValue@ sval)
	{
		auto arrCheats = sval.GetArray();
		for (uint i = 0; i < arrCheats.length(); i++)
		{
			auto svCheat = arrCheats[i];
			string className = GetParamString(UnitPtr(), svCheat, "class");

			auto newCheat = cast<Cheat>(InstantiateClass(className, UnitPtr(), svCheat));
			if (newCheat is null)
			{
				PrintError(className + " is not of type Cheat!");
				continue;
			}

			g_cheats.insertLast(newCheat);
		}
	}

	Cheat@ GetCheat(string id)
	{
		for (uint i = 0; i < g_cheats.length(); i++)
		{
			if (g_cheats[i].m_id == id)
				return g_cheats[i];
		}
		return null;
	}

	[Hook]
	void GameModeStart(Campaign@ campaign, SValue@ save)
	{
		if (save !is null)
			@g_savedCheats = GetParamArray(UnitPtr(), save, "enabled-cheats", false);

		campaign.m_userWindows.insertLast(@g_interface = TrainerInterface(campaign.m_guiBuilder));
	}

	[Hook]
	void GameModePostStart(Campaign@ campaign)
	{
		if (g_savedCheats is null)
			return;

		for (uint i = 0; i < g_savedCheats.length(); i++)
		{
			auto svCheat = g_savedCheats[i];
			string id = GetParamString(UnitPtr(), svCheat, "id");

			auto cheat = GetCheat(id);
			if (cheat is null)
				continue;

			cheat.Load(svCheat);
		}
	}

	[Hook]
	void GameModeUpdate(Campaign@ campaign, int dt, GameInput& gameInput, MenuInput& menuInput)
	{
		if (g_interface is null)
			return;

		if (Platform::GetKeyState(DefinedKey::F3).Pressed)
			campaign.ToggleUserWindow(g_interface);

		for (uint i = 0; i < g_cheats.length(); i++)
			g_cheats[i].Update(dt);
	}

	[Hook]
	void GameModeSave(Campaign@ campaign, SValueBuilder &builder)
	{
		builder.PushArray("enabled-cheats");
		for (uint i = 0; i < g_cheats.length(); i++)
		{
			auto cheat = g_cheats[i];

			builder.PushDictionary();
			builder.PushString("id", cheat.m_id);
			cheat.Save(builder);
			builder.PopDictionary();
		}
		builder.PopArray();
	}
}
