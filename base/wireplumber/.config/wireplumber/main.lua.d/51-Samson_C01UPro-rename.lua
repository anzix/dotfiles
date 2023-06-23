rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_output.usb-Samson_Technologies_Samson_C01U_Pro_Mic-00.analog-stereo" },
    },
  },
  apply_properties = {
    ["node.description"] = "C01U Pro",
  },
}

table.insert(alsa_monitor.rules, rule)

rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.usb-Samson_Technologies_Samson_C01U_Pro_Mic-00.mono-fallback" },
    },
  },
  apply_properties = {
    ["node.description"] = "C01U Pro",
	["node.nick"] = "C01U Pro"
  },
}

table.insert(alsa_monitor.rules, rule)
