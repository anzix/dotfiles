rule = {
	matches = {
		{
			{ "device.name", "equals", "alsa_card.pci-0000_03_00.1" },
		},
		{
			{ "device.name", "equals", "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra5" },
		},
	},
	apply_properties = {
		["device.disabled"] = true,
	},
}

table.insert(alsa_monitor.rules, rule)
