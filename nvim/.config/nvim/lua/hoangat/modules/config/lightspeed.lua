require("lightspeed").setup {
  ignore_case = true,
  substitute_chars = { ["\r"] = "¬" },
  --- f/t ---
  limit_ft_matches = 8,
  repeat_ft_with_target_char = false,
}
