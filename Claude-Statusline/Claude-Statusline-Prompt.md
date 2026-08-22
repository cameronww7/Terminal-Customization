Write a Claude Code statusline as a Python script.

* Write it as a Python script at ~/.claude/statusline.py (don't use jq — assume it's not installed; use Python's built-in json module to parse stdin).
* Display, in this exact order, on one line, with a pipe | separating every field: a literal prefix 🍀 - TryHard3r, then the model's display name in brackets, then effort level (if present) as eff:, then total session cost as $X.XX, then total tokens used (input+output combined, formatted as e.g. 48.2k tok or 1.2M tok), then a 10-character block progress bar (▓/░) showing context window usage with the percentage and max context size, e.g. ▓▓░░░░░░░░ 24% (200.0k max), then the last two path segments of the current working directory joined with a single /, e.g. if the cwd is /home/user/dev, show /user/dev. If the cwd only has one segment (e.g. /home), show just that one segment, e.g. /home.
* Fields to pull from the stdin JSON: model.display_name, effort.level (omit the eff: segment entirely if absent), cost.total_cost_usd, context_window.total_input_tokens + context_window.total_output_tokens, context_window.used_percentage, context_window.context_window_size.
* Handle nulls gracefully: if used_percentage is null (early in session), show -- instead of a bar.
* Color the entire output line in neon green using ANSI 256-color code 46, bold (\033[1;38;5;46m ... \033[0m) — full "Matrix" theme, not just one field.
* Make the script executable (chmod +x).
* Wire it into ~/.claude/settings.json under a statusLine key: {"type": "command", "command": "python3 ~/.claude/statusline.py", "padding": 2} — merge into the existing settings.json, don't overwrite other keys.
* Test it first with mock JSON piped via stdin before wiring it in, to confirm formatting and colors render correctly.
