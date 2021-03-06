local gps = safe_require "nvim-gps"

local icons = require "hoangat.core.icons"

gps.setup {

  disable_icons = false, -- Setting it to true will disable all icons

  icons = {
    ["class-name"] = "%#GpsItemKindClass#" .. icons.kind.Class .. "%*" .. " ", -- Classes and class-like objects
    ["function-name"] = "%#GpsItemKindFunction#" .. icons.kind.Function .. "%*" .. " ", -- Functions
    ["method-name"] = "%#GpsItemKindMethod#" .. icons.kind.Method .. "%*" .. " ", -- Methods (functions inside class-like objects)
    ["container-name"] = "%#GpsItemKindProperty#" .. icons.type.Object .. "%*" .. " ", -- Containers (example: lua tables)
    ["tag-name"] = "%#GpsItemKindKeyword#" .. icons.misc.Tag .. "%*" .. " ", -- Tags (example: html tags)
    ["mapping-name"] = "%#GpsItemKindProperty#" .. icons.type.Object .. "%*" .. " ",
    ["sequence-name"] = "%GpsItemKindProperty#" .. icons.type.Array .. "%*" .. " ",
    ["null-name"] = "%GpsItemKindField#" .. icons.kind.Field .. "%*" .. " ",
    ["boolean-name"] = "%GpsItemKindValue#" .. icons.type.Boolean .. "%*" .. " ",
    ["integer-name"] = "%GpsItemKindValue#" .. icons.type.Number .. "%*" .. " ",
    ["float-name"] = "%GpsItemKindValue#" .. icons.type.Number .. "%*" .. " ",
    ["string-name"] = "%GpsItemKindValue#" .. icons.type.String .. "%*" .. " ",
    ["array-name"] = "%GpsItemKindProperty#" .. icons.type.Array .. "%*" .. " ",
    ["object-name"] = "%GpsItemKindProperty#" .. icons.type.Object .. "%*" .. " ",
    ["number-name"] = "%GpsItemKindValue#" .. icons.type.Number .. "%*" .. " ",
    ["table-name"] = "%GpsItemKindProperty#" .. icons.ui.Table .. "%*" .. " ",
    ["date-name"] = "%GpsItemKindValue#" .. icons.ui.Calendar .. "%*" .. " ",
    ["date-time-name"] = "%GpsItemKindValue#" .. icons.ui.Table .. "%*" .. " ",
    ["inline-table-name"] = "%GpsItemKindProperty#" .. icons.ui.Calendar .. "%*" .. " ",
    ["time-name"] = "%GpsItemKindValue#" .. icons.misc.Watch .. "%*" .. " ",
    ["module-name"] = "%GpsItemKindModule#" .. icons.kind.Module .. "%*" .. " ",
  },

  -- icons = {
  --   ["class-name"] = "%#CmpItemKindClass#" .. icons.kind.Class .. "%*" .. " ", -- Classes and class-like objects
  --   ["function-name"] = "%#CmpItemKindFunction#" .. icons.kind.Function .. "%*" .. " ", -- Functions
  --   ["method-name"] = "%#CmpItemKindMethod#" .. icons.kind.Method .. "%*" .. " ", -- Methods (functions inside class-like objects)
  --   ["container-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. " ", -- Containers (example: lua tables)
  --   ["tag-name"] = "%#CmpItemKindKeyword#" .. icons.misc.Tag .. "%*" .. " ", -- Tags (example: html tags)
  --   ["mapping-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. " ",
  --   ["sequence-name"] = "%CmpItemKindProperty#" .. icons.type.Array .. "%*" .. " ",
  --   ["null-name"] = "%CmpItemKindField#" .. icons.kind.Field .. "%*" .. " ",
  --   ["boolean-name"] = "%CmpItemKindValue#" .. icons.type.Boolean .. "%*" .. " ",
  --   ["integer-name"] = "%CmpItemKindValue#" .. icons.type.Number .. "%*" .. " ",
  --   ["float-name"] = "%CmpItemKindValue#" .. icons.type.Number .. "%*" .. " ",
  --   ["string-name"] = "%CmpItemKindValue#" .. icons.type.String .. "%*" .. " ",
  --   ["array-name"] = "%CmpItemKindProperty#" .. icons.type.Array .. "%*" .. " ",
  --   ["object-name"] = "%CmpItemKindProperty#" .. icons.type.Object .. "%*" .. " ",
  --   ["number-name"] = "%CmpItemKindValue#" .. icons.type.Number .. "%*" .. " ",
  --   ["table-name"] = "%CmpItemKindProperty#" .. icons.ui.Table .. "%*" .. " ",
  --   ["date-name"] = "%CmpItemKindValue#" .. icons.ui.Calendar .. "%*" .. " ",
  --   ["date-time-name"] = "%CmpItemKindValue#" .. icons.ui.Table .. "%*" .. " ",
  --   ["inline-table-name"] = "%CmpItemKindProperty#" .. icons.ui.Calendar .. "%*" .. " ",
  --   ["time-name"] = "%CmpItemKindValue#" .. icons.misc.Watch .. "%*" .. " ",
  --   ["module-name"] = "%CmpItemKindModule#" .. icons.kind.Module .. "%*" .. " ",
  -- },

  -- Add custom configuration per language or
  -- Disable the plugin for a language
  -- Any language not disabled here is enabled by default
  -- languages = {
  -- 	-- Some languages have custom icons
  -- 	["json"] = {
  -- 		icons = {
  -- 		}
  -- 	},
  -- 	["toml"] = {
  -- 		icons = {
  -- 		}
  -- 	},
  -- 	["verilog"] = {
  -- 		icons = {
  -- 		}
  -- 	},
  -- 	["yaml"] = {
  -- 		icons = {
  -- 		}
  -- 	},

  -- Disable for particular languages
  -- ["bash"] = false, -- disables nvim-gps for bash
  -- ["go"] = false,   -- disables nvim-gps for golang

  -- Override default setting for particular languages
  -- ["ruby"] = {
  --	separator = '|', -- Overrides default separator with '|'
  --	icons = {
  --		-- Default icons not specified in the lang config
  --		-- will fallback to the default value
  --		-- "container-name" will fallback to default because it's not set
  --		["function-name"] = '',    -- to ensure empty values, set an empty string
  --		["tag-name"] = ''
  --		["class-name"] = '::',
  --		["method-name"] = '#',
  --	}
  --}
  -- },

  separator = " " .. icons.ui.ChevronRight .. " ",

  -- limit for amount of context shown
  -- 0 means no limit
  -- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
  -- in context names (eg: function names, class names, etc)
  depth = 5,

  -- indicator used when context is hits depth limit
  depth_limit_indicator = "..",
  text_hl = "AlphaHeader",
} -- Customized config
