local function placeholder_buffer(cmd)
  -- Run the command and capture its output
  local handle = io.popen(cmd, 'r')
  if handle then
    local command_output = handle:read("*a")
    handle:close()

    -- Split the output into lines
    local lines = {}
    for line in command_output:gmatch("[^\r\n]+") do
      table.insert(lines, line)
    end

    -- Create a new buffer and open it in a split window
    local buf = vim.api.nvim_create_buf(true, true) -- Create a new empty buffer
    vim.api.nvim_command('sp') -- Open a vertical split (use 'sp' for horizontal split)
    vim.api.nvim_win_set_buf(0, buf) -- Set the current window to the new buffer

    vim.api.nvim_buf_set_name(buf, "gpt")

    -- Set the filetype of the new buffer to Markdown
    vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')

    -- Insert the output into the new buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  else
    -- Error handling if the command couldn't be executed
    print("Failed to run command")
  end
end

local function placeholder(start_line, end_line, cmd)
  -- Save the current cursor position
  local save_cursor = vim.api.nvim_win_get_cursor(0)

  -- Execute the selected text as a Bash command
  local output = vim.fn.system(cmd)

  -- Split the output into lines
  local lines = vim.split(output, "\n")

  -- Remove the last line if it's empty (due to the final newline)
  if lines[#lines] == "" then
    table.remove(lines, #lines)
  end

  --vim.api.nvim_buf_set_lines(0, save_cursor[1], save_cursor[1], false, lines)
  vim.api.nvim_buf_set_lines(0, end_line, end_line, false, lines)

  -- Move the cursor back to its original position
  vim.api.nvim_win_set_cursor(0, save_cursor)
end

local function runit(start_line, end_line)
  local selected_text = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
  selected_text = selected_text:gsub("'", "'\\''")
  local cmd = string.format([[bash -c 'source ~/.drv.profile; %s']], selected_text)
  placeholder(start_line, end_line, cmd)
end

local function calcit(start_line, end_line)
  local selected_text = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
  local cmd ="bash -c 'source ~/.drv.profile; echo \"\"\" " .. selected_text .. "  \"\"\" | bc '"
  placeholder(start_line, end_line, cmd)
end

local function beautify_bash_command(start_line, end_line)
  -- Get the lines from the buffer for the given range
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Join the lines to create one continuous string
  local cmd = table.concat(lines, " ")

  -- Perform the substitution similar to the Vim command
  -- Replace occurrences of a space followed by a dash and a word character with a space, backslash, newline, and tab
  cmd = cmd:gsub(" (%-[%-%w]+)", " \\\r\t%1")

  -- Split the command back into lines at newline characters
  local beautified_lines = {}
  for line in cmd:gmatch("([^\r\n]+)") do
    table.insert(beautified_lines, line)
  end

  -- Replace the selected lines with the beautified command
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, beautified_lines)
end

local function run_command_buffer(start_line, end_line, cmd)
  local selected_text = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
  selected_text = selected_text:gsub("'", "'\\''")
  local cmd = string.format([[bash -c 'source ~/.drv.profile; %s']], selected_text)

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(true, true)

  -- Execute the command
  local output = vim.fn.system(cmd)

  -- Split the output into lines
  local lines = vim.split(output, "\n")

  -- Remove the last line if it's empty (due to the final newline)
  if lines[#lines] == "" then
    table.remove(lines, #lines)
  end

  -- Set the lines in the new buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Open the buffer in a new window
  vim.api.nvim_win_set_buf(0, buf)
end

local function chatgpt(start_line, end_line)
  local selected_text = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), "\n")
  selected_text = selected_text:gsub("'", "'\\''")
  local cmd = string.format([[bash -c 'source ~/.drv.profile; echo """%s""" | _sc']], selected_text)
  --placeholder(start_line, end_line, cmd)
  placeholder_buffer(cmd)
end

local function runit_fixed(input)
  --local cmd ="bash -c 'source ~/.drv.profile; " .. input .. "'"
  local cmd ="bash -c '" .. input .. "'"
  placeholder(0, 0, cmd)
end

local function list_functions()
  require('telescope.builtin').lsp_dynamic_workspace_symbols({
    ignore_symbols = { 'variable', 'constant', 'field', 'class', 'struct', 'method' }
  })
end

return {
  runit = runit,
  calcit = calcit,
  chatgpt = chatgpt,
  beautify_bash_command = beautify_bash_command,
  run_command_buffer = run_command_buffer,
  runit_fixed = runit_fixed,
  list_functions = list_functions
}
