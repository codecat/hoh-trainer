namespace Trainer
{
	class NoKeysRequired : Cheat
	{
		array<PlayerUsable@> m_unlockedUsables;

		NoKeysRequired(UnitPtr unit, SValue &params)
		{
			super(unit, params);
		}

		void UnlockUsable(PlayerUsable@ usable)
		{
			auto chest = cast<Chest>(usable.m_usable);
			if (chest !is null && chest.m_lock >= 0)
				chest.m_lock -= 100; // 0 = -100, 1 = -99
		}

		void LockUsable(PlayerUsable@ usable)
		{
			auto chest = cast<Chest>(usable.m_usable);
			if (chest !is null && chest.m_lock < -1)
				chest.m_lock += 100; // -100 = 0, -99 = 1
		}

		void OnDisabled() override
		{
			for (uint i = 0; i < m_unlockedUsables.length(); i++)
				LockUsable(m_unlockedUsables[i]);
			m_unlockedUsables.removeRange(0, m_unlockedUsables.length());
		}

		void Update(int dt) override
		{
			if (!m_enabled)
				return;

			auto player = GetLocalPlayer();
			if (player is null)
				return;

			for (uint i = 0; i < player.m_usables.length(); i++)
			{
				auto usable = player.m_usables[i];
				if (m_unlockedUsables.findByRef(usable) == -1)
				{
					UnlockUsable(usable);
					m_unlockedUsables.insertLast(usable);
				}
			}

			for (int i = int(m_unlockedUsables.length() - 1); i >= 0; i--)
			{
				auto usable = m_unlockedUsables[i];
				if (usable.m_refCount <= 0)
				{
					LockUsable(usable);
					m_unlockedUsables.removeAt(i);
				}
			}
		}
	}
}
