local M = {}

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-tree/nvim-web-devicons",
}

M.cmd = {
  "Octo",
}

M.keys = {

  --[[
  gh  -> github
  ghl -> label
  -- gha -> actions
  gho -> assignee
  ghc -> card
  ghi -> issue
  ghj -> comment
  -- gho -> reviewer
  ghp -> pr
  ghp -> repo
  ghr -> review
  ghs -> search
  ght -> thread
  ghu -> react
  -- ghg -> Gist
  --]]

  -- stylua: ignore start
  -- Gist
  {"<leader>ghg", "<cmd> Octo gist list<CR>",            mode = "n", desc = "List Gists"             },

  -- Actions (list)
  {"<leader>gha", "<cmd> Octo actions<CR>",            mode = "n", desc = "List Actions"             },

  -- Repo
  {"<leader>ghpl", "<cmd> Octo repo list<CR>",            mode = "n", desc = "List Repo"              },
  {"<leader>ghpf", "<cmd> Octo repo fork<CR>",            mode = "n", desc = "Fork Repo"              },
  {"<leader>ghpu", "<cmd> Octo repo url<CR>",             mode = "n", desc = "Url Repo"               },
  {"<leader>ghpv", "<cmd> Octo repo view<CR>",            mode = "n", desc = "View Repo"              },
  {"<leader>ghpb", "<cmd> Octo repo browser<CR>",         mode = "n", desc = "Browser Repo"           },

  -- React
  {"<leader>ghuh", "<cmd> Octo reaction heart<CR>",       mode = "n", desc = "React with heart"       },
  {"<leader>ghur", "<cmd> Octo reaction rocket<CR>",      mode = "n", desc = "React with rocket"      },
  {"<leader>ghut", "<cmd> Octo reaction tada<CR>",        mode = "n", desc = "React with tada"        },
  {"<leader>ghup", "<cmd> Octo reaction party<CR>",       mode = "n", desc = "React with party"       },
  {"<leader>ghuo", "<cmd> Octo reaction hooray<CR>",      mode = "n", desc = "React with hooray"      },
  {"<leader>ghuc", "<cmd> Octo reaction confused<CR>",    mode = "n", desc = "React with confused"    },
  {"<leader>ghul", "<cmd> Octo reaction laugh<CR>",       mode = "n", desc = "React with laugh"       },
  {"<leader>ghue", "<cmd> Octo reaction eyes<CR>",        mode = "n", desc = "React with eyes"        },
  {"<leader>ghum", "<cmd> Octo reaction -1<CR>",          mode = "n", desc = "Upvote"                 },
  {"<leader>ghup", "<cmd> Octo reaction +1<CR>",          mode = "n", desc = "Downvote"               },
  {"<leader>ghud", "<cmd> Octo reaction thumbs_down<CR>", mode = "n", desc = "React with thumbs_down" },
  {"<leader>ghuu", "<cmd> Octo reaction thumbs_up<CR>",   mode = "n", desc = "React with thumbs_up"   },

  -- Comment
  {"<leader>ghja", "<cmd> Octo comment add<CR>",    mode = "n", desc =    "Add Comment" },
  {"<leader>ghjd", "<cmd> Octo comment delete<CR>", mode = "n", desc = "Delete Comment" },

  -- Card
  {"<leader>ghcm", "<cmd> Octo card move<CR>",   mode = "n", desc = "Move Card"   },
  {"<leader>ghcr", "<cmd> Octo card remove<CR>", mode = "n", desc = "Remove Card" },
  {"<leader>ghca", "<cmd> Octo card add<CR>",    mode = "n", desc = "Add Card"    },

  -- Review
  {"<leader>ghrc", "<cmd> Octo review close<CR>",    mode = "n", desc = "Close Review"    },
  {"<leader>ghrs", "<cmd> Octo review start<CR>",    mode = "n", desc = "Start Review"    },
  {"<leader>ghrd", "<cmd> Octo review discard<CR>",  mode = "n", desc = "Discard Review"  },
  {"<leader>ghrr", "<cmd> Octo review resume<CR>",   mode = "n", desc = "Resume Review"   },
  {"<leader>ghrs", "<cmd> Octo review submit<CR>",   mode = "n", desc = "Submit Review"   },
  {"<leader>ghrc", "<cmd> Octo review commit<CR>",   mode = "n", desc = "Commit Review"   },
  {"<leader>ghra", "<cmd> Octo review comments<CR>", mode = "n", desc = "comments Review" },

  -- Thread
  {"<leader>ght", "<cmd> Octo thread resolve<CR>",   mode = "n", desc = "Resolve Thread"   },
  {"<leader>ght", "<cmd> Octo thread unresolve<CR>", mode = "n", desc = "Unresolve Thread" },

  -- PR
  {"<leader>ghnu", "<cmd> Octo pr url<CR>",      mode = "n", desc = "PR Url"             },
  {"<leader>ghne", "<cmd> Octo pr edit<CR>",     mode = "n", desc = "Edit PR"            },
  {"<leader>ghnr", "<cmd> Octo pr reopen<CR>",   mode = "n", desc = "Reopen PR "         },
  {"<leader>ghns", "<cmd> Octo pr search<CR>",   mode = "n", desc = "Search PR"          },
  {"<leader>ghnc", "<cmd> Octo pr commits<CR>",  mode = "n", desc = "Check PR Commits"   },
  {"<leader>ghnh", "<cmd> Octo pr checks<CR>",   mode = "n", desc = "PR Checks"          },
  {"<leader>ghnl", "<cmd> Octo pr reload<CR>",   mode = "n", desc = "Reload PR"          },
  {"<leader>ghnb", "<cmd> Octo pr browser<CR>",  mode = "n", desc = "Open PR in Browser" },
  {"<leader>ghnm", "<cmd> Octo pr merge<CR>",    mode = "n", desc = "Merge PR"           },
  {"<leader>ghnn", "<cmd> Octo pr create<CR>",   mode = "n", desc = "Create PR"          },
  {"<leader>ghno", "<cmd> Octo pr checkout<CR>", mode = "n", desc = "Checkout PR"        },
  {"<leader>ghnt", "<cmd> Octo pr close<CR>",    mode = "n", desc = "Close PR"           },
  {"<leader>ghnq", "<cmd> Octo pr list<CR>",     mode = "n", desc = "List PR"            },
  {"<leader>ghnd", "<cmd> Octo pr diff<CR>",     mode = "n", desc = "PR Diff"            },
  {"<leader>ghnz", "<cmd> Octo pr changes<CR>",  mode = "n", desc = "PR Changes"         },
  {"<leader>ghnp", "<cmd> Octo pr ready<CR>",    mode = "n", desc = "Ready PR"           },

  -- Search
  {"<leader>ghs",   "<cmd> Octo search<CR>", mode = "n", desc = "Search Github" },

  -- Assignee
  {"<leader>ghoa", "<cmd> Octo assignee add<CR>",    mode = "n", desc = "Add Assignee"    },
  {"<leader>ghor", "<cmd> Octo assignee remove<CR>", mode = "n", desc = "Remove Assignee" },

  -- Reviewer
  {"<leader>ghk",   "<cmd> Octo reviewer add<CR>", mode = "n", desc = "Add Code Reviewer" },

  -- Issue
  {"<leader>ghib", "<cmd> Octo issue browser<CR>", mode = "n", desc = "Issue Browser" },
  {"<leader>ghir", "<cmd> Octo issue reopen<CR>",  mode = "n", desc = "Reopen Issue"  },
  {"<leader>ghic", "<cmd> Octo issue create<CR>",  mode = "n", desc = "Create Issue"  },
  {"<leader>ghis", "<cmd> Octo issue search<CR>",  mode = "n", desc = "Search Issue"  },
  {"<leader>ghiu", "<cmd> Octo issue url<CR>",     mode = "n", desc = "Url of Issue"  },
  {"<leader>ghil", "<cmd> Octo issue list<CR>",    mode = "n", desc = "List Issue"    },
  {"<leader>ghie", "<cmd> Octo issue edit<CR>",    mode = "n", desc = "Edit Issue"    },
  {"<leader>ghix", "<cmd> Octo issue close<CR>",   mode = "n", desc = "Close Issue"   },
  {"<leader>ghid", "<cmd> Octo issue reload<CR>",  mode = "n", desc = "Reload Issue"  },


  -- Label
  {"<leader>ghlc", "<cmd> Octo label create<CR>", mode = "n", desc = "Create Label" },
  {"<leader>ghla", "<cmd> Octo label add<CR>",    mode = "n", desc = "Add Label"    },
  {"<leader>ghlr", "<cmd> Octo label remove<CR>", mode = "n", desc = "Remove Label" },

  -- {"<leader>gh",   "<cmd> Octo<CR>", mode = "n", desc = "Github" },

  -- stylua: ignore end
}

M.opts = {
  use_local_fs = false, -- use local files on right side of reviews
  enable_builtin = false, -- shows a list of builtin actions when no action is provided
  default_remote = { "upstream", "origin" }, -- order to try remotes
  ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
  reaction_viewer_hint_icon = "", -- marker for user reactions
  user_icon = " ", -- user icon
  timeline_marker = "", -- timeline marker
  timeline_indent = "2", -- timeline indentation
  right_bubble_delimiter = "", -- bubble delimiter
  left_bubble_delimiter = "", -- bubble delimiter
  github_hostname = "", -- GitHub Enterprise host
  snippet_context_lines = 4, -- number or lines around commented lines
  gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
  timeout = 5000, -- timeout for requests between the remote server
  ui = {
    use_signcolumn = true, -- show "modified" marks on the sign column
  },
  issues = {
    order_by = { -- criteria to sort results of `Octo issue list`
      field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    },
  },
  pull_requests = {
    order_by = { -- criteria to sort the results of `Octo pr list`
      field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
      direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
    },
    always_select_remote_on_create = "false", -- always give prompt to select base remote repo when creating PRs
  },
  file_panel = {
    size = 10, -- changed files panel rows
    use_icons = true, -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
  },
  mappings = {
    --   issue = {
    --     close_issue = { lhs = "<space>ic", desc = "close issue" },
    --     reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
    --     list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
    --     reload = { lhs = "<C-r>", desc = "reload issue" },
    --     open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
    --     copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
    --     add_assignee = { lhs = "<space>aa", desc = "add assignee" },
    --     remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
    --     create_label = { lhs = "<space>lc", desc = "create label" },
    --     add_label = { lhs = "<space>la", desc = "add label" },
    --     remove_label = { lhs = "<space>ld", desc = "remove label" },
    --     goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
    --     add_comment = { lhs = "<space>ca", desc = "add comment" },
    --     delete_comment = { lhs = "<space>cd", desc = "delete comment" },
    --     next_comment = { lhs = "]c", desc = "go to next comment" },
    --     prev_comment = { lhs = "[c", desc = "go to previous comment" },
    --     react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
    --     react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
    --     react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
    --     react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
    --     react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
    --     react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
    --     react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
    --     react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    --   },
    --   pull_request = {
    --     checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
    --     merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
    --     squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
    --     list_commits = { lhs = "<space>pc", desc = "list PR commits" },
    --     list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
    --     show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
    --     add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
    --     remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
    --     close_issue = { lhs = "<space>ic", desc = "close PR" },
    --     reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
    --     list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
    --     reload = { lhs = "<C-r>", desc = "reload PR" },
    --     open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
    --     copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
    --     goto_file = { lhs = "gf", desc = "go to file" },
    --     add_assignee = { lhs = "<space>aa", desc = "add assignee" },
    --     remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
    --     create_label = { lhs = "<space>lc", desc = "create label" },
    --     add_label = { lhs = "<space>la", desc = "add label" },
    --     remove_label = { lhs = "<space>ld", desc = "remove label" },
    --     goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
    --     add_comment = { lhs = "<space>ca", desc = "add comment" },
    --     delete_comment = { lhs = "<space>cd", desc = "delete comment" },
    --     next_comment = { lhs = "]c", desc = "go to next comment" },
    --     prev_comment = { lhs = "[c", desc = "go to previous comment" },
    --     react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
    --     react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
    --     react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
    --     react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
    --     react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
    --     react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
    --     react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
    --     react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    --   },
    --   review_thread = {
    --     goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
    --     add_comment = { lhs = "<space>ca", desc = "add comment" },
    --     add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
    --     delete_comment = { lhs = "<space>cd", desc = "delete comment" },
    --     next_comment = { lhs = "]c", desc = "go to next comment" },
    --     prev_comment = { lhs = "[c", desc = "go to previous comment" },
    --     select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
    --     select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
    --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    --     react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
    --     react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
    --     react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
    --     react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
    --     react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
    --     react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
    --     react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
    --     react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    --   },
    --   submit_win = {
    --     approve_review = { lhs = "<C-a>", desc = "approve review" },
    --     comment_review = { lhs = "<C-m>", desc = "comment review" },
    --     request_changes = { lhs = "<C-r>", desc = "request changes review" },
    --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    --   },
    --   review_diff = {
    --     add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
    --     add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
    --     focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
    --     toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
    --     next_thread = { lhs = "]t", desc = "move to next thread" },
    --     prev_thread = { lhs = "[t", desc = "move to previous thread" },
    --     select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
    --     select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
    --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    --     toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    --     goto_file = { lhs = "gf", desc = "go to file" },
    --   },
    --   file_panel = {
    --     next_entry = { lhs = "j", desc = "move to next changed file" },
    --     prev_entry = { lhs = "k", desc = "move to previous changed file" },
    --     select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
    --     refresh_files = { lhs = "R", desc = "refresh changed files panel" },
    --     focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
    --     toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
    --     select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
    --     select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
    --     close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    --     toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    --   },
  },
}

return M
