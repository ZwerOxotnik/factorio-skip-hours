
data:extend({
	{
		type = "int-setting",
		name = "sh-hours",
		setting_type = "runtime-global",
		default_value = 2,
		allowed_values = {0, 1, 2, 5, 8, 10}
	},
	{
		type = "double-setting",
		name = "sh-item-multiplier",
		setting_type = "runtime-global",
		minimum_value = 1,
		maximum_value = 100,
		default_value = 4
	}
})
