# Trainer
Trainer mod for Heroes of Hammerwatch, which can also be extended upon by other mods. It also serves as a good example project of what you can do with the modding API. (Hooks, sval loaders, etc.)

Once installed, you can press F3 in game to open the trainer menu.

![](Trainer.gif)

## Features
The trainer ships with the following features:

* Infinite health
* Infinite mana
* Fast walking
* No skill cooldown
* Auto skills
* Give 10k gold
* Give 100k gold
* Give 10 ore
* Give 100 ore
* No keys required
* Give bronze key
* Give silver key
* Give gold key
* Give ace key
* Level up +1
* Level up +5

## Custom cheats
It's very easy to make a mod that adds cheats to this trainer. First, [make a mod](http://wiki.heroesofhammerwatch.com/Mod_base). Then, add a new `.sval` file to your mod. Make sure the path to this file is unique, so that you don't accidentally overwrite files from other mods. In this sval file, you'll use the trainer's custom [sval loader](http://wiki.heroesofhammerwatch.com/SValue_Loaders), `Trainer::AddCheats`.

Each cheat must have a unique ID, a name, and a description.

The following example file adds a cheat for a 10x gold pickup multiplier:

```xml
<loader>Trainer::AddCheats</loader>
<array>
	<dict>
		<string name="class">Trainer::ModifierCheat</string>

		<string name="id">massivegold</string>
		<string name="name">Massive Gold</string>
		<string name="description">Gold you pick up is worth 10x as much.</string>

		<dict name="modifier">
			<string name="class">Modifiers::GoldGain</string>
			<float name="scale">10</float>
		</dict>
	</dict>
</array>
```

The available built-in cheat classes are: `Tainer::AutoSkills`, `Trainer::EffectCheat`, `Trainer::LevelUpCheat`, `Trainer::ModifierCheat`, `Trainer::NoKeysRequired`, and `Trainer::NoSkillCooldown`.

You can make a more advanced cheat by using a custom class. To do this, you can make a class inherit from `Trainer::Cheat`. Take a look at [TrainerCheat.as](scripts/TrainerCheat.as) for more details.
