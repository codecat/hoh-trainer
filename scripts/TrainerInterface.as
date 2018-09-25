namespace Trainer
{
	class TrainerInterface : UserWindow
	{
		ScrollableWidget@ m_wList;
		Widget@ m_wTemplateCheck;
		Widget@ m_wTemplateButton;

		TrainerInterface(GUIBuilder@ b)
		{
			super(b, "gui/trainer.gui");

			@m_wList = cast<ScrollableWidget>(m_widget.GetWidgetById("list"));
			@m_wTemplateCheck = m_widget.GetWidgetById("template-check");
			@m_wTemplateButton = m_widget.GetWidgetById("template-button");
		}

		void Show() override
		{
			m_wList.PauseScrolling();
			m_wList.ClearChildren();

			for (uint i = 0; i < g_cheats.length(); i++)
			{
				auto cheat = g_cheats[i];

				Widget@ wNewCheat = null;

				if (cheat.m_type == CheatType::Togglable)
				{
					auto wNewCheckbox = cast<CheckBoxWidget>(m_wTemplateCheck.Clone());
					wNewCheckbox.m_value = "" + i;
					wNewCheckbox.m_func = "toggled";
					wNewCheckbox.SetText(cheat.m_name);
					wNewCheckbox.SetChecked(cheat.m_enabled);
					@wNewCheat = wNewCheckbox;
				}
				else if (cheat.m_type == CheatType::Action)
				{
					auto wNewButton = cast<ScalableSpriteButtonWidget>(m_wTemplateButton.Clone());
					wNewButton.m_func = "action " + i;
					wNewButton.SetText(cheat.m_name);
					@wNewCheat = wNewButton;
				}

				if (wNewCheat is null)
					continue;

				wNewCheat.m_visible = true;
				wNewCheat.SetID("");

				if (cheat.m_description != "")
					wNewCheat.m_tooltipText = cheat.m_description;

				m_wList.AddChild(wNewCheat);
			}

			m_wList.ResumeScrolling();

			UserWindow::Show();
		}

		void OnFunc(Widget@ sender, string name) override
		{
			auto parse = name.split(" ");
			if (parse[0] == "toggled")
			{
				auto check = cast<CheckBoxWidget>(sender);
				if (check !is null)
				{
					int index = parseInt(check.GetValue());
					auto cheat = g_cheats[index];
					cheat.SetEnabled(check.IsChecked());
				}
			}
			else if (parse[0] == "action" && parse.length() == 2)
			{
				int index = parseInt(parse[1]);
				auto cheat = g_cheats[index];
				cheat.OnClicked();
			}
			else
				UserWindow::OnFunc(sender, name);
		}
	}
}
