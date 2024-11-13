To move a line up or down in Vim, you can use the following commands:

1. To move a line up:
   - Place the cursor on the line you want to move.
   - Press `ddkP` to cut the line and paste it above.

2. To move a line down:
   - Place the cursor on the line you want to move.
   - Press `ddp` to cut the line and paste it below.

Here's a breakdown of the commands:

- `dd` - Cuts (deletes) the current line.
- `k` - Moves the cursor up one line.
- `P` - Pastes the line above the current line.
- `p` - Pastes the line below the current line.

You can also use the following more concise commands:

- To move a line up: `ddkP`
- To move a line down: `ddp`

Alternatively, you can use the `<C-e>` (Ctrl+e) and `<C-y>` (Ctrl+y) commands to move the entire screen up or down, respectively, while keeping the cursor on the same line.

Note that these commands will move the entire line, including any indentation or leading spaces. If you want to move just the text content of the line, you can use the following commands:

1. To move the text of a line up:
   - Place the cursor on the line you want to move.
   - Press `V` to enter visual line mode, then `k` to select the line above.
   - Press `d` to cut the selected line, then `p` to paste it above.

2. To move the text of a line down:
   - Place the cursor on the line you want to move.
   - Press `V` to enter visual line mode, then `j` to select the line below.
   - Press `d` to cut the selected line, then `p` to paste it below.
