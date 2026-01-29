Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("green"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("blue"),
		" ",
	})
end, 500, Status.RIGHT)

require("git"):setup()

require("githead"):setup({
  order = {
    "__spacer__",
    "branch",
    "remote",
    "__spacer__",
    "tag",
    "__spacer__",
    "commit",
    "__spacer__",
    "behind_ahead_remote",
    "__spacer__",
    "stashes",
    "__spacer__",
    "state",
    "__spacer__",
    "staged",
    "__spacer__",
    "unstaged",
    "__spacer__",
    "untracked",
  },

  show_numbers = true, -- shows staged, unstaged, untracked, stashes count

  show_branch = true,
  branch_prefix = "on",
  branch_color = "blue",
  branch_symbol = "   ",
  branch_borders = "",

  show_remote_branch = true, -- only shown if different from local branch
  always_show_remote_branch = false, -- always show remote branch even if it the same as local branch
  always_show_remote_repo = false, -- Adds `origin/` if `always_show_remote_branch` is enabled
  remote_branch_prefix = ":",
  remote_branch_color = "bright magenta",

  show_tag = true, -- only shown if branch is not available
  always_show_tag = false,
  tag_color = "magenta",
  tag_symbol = "#",

  show_commit = true, -- only shown if branch AND tag are not available
  always_show_commit = false,
  commit_color = "bright magenta",
  commit_symbol = "@",

  show_behind_ahead_remote = true,
  behind_remote_color = "bright magenta",
  behind_remote_symbol = "⇣",
  ahead_remote_color = "bright magenta",
  ahead_remote_symbol = "⇡",

  show_stashes = true,
  stashes_color = "bright magenta",
  stashes_symbol = "$",

  show_state = true,
  show_state_prefix = true,
  state_color = "red",
  state_symbol = "~",

  show_staged = true,
  staged_color = "bright yellow",
  staged_symbol = "+",

  show_unstaged = true,
  unstaged_color = "bright yellow",
  unstaged_symbol = "!",

  show_untracked = true,
  untracked_color = "blue",
  untracked_symbol = "?",
})
