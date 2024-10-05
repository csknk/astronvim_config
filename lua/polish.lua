-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
-- Set up custom filetypes
vim.filetype.add {
    extension = {foo = "fooscript"},
    filename = {["Foofile"] = "fooscript"},
    pattern = {["~/%.config/foo/.*"] = "fooscript"}
}
-- Start certain filetypes with a template
-- see plugins/astrocore.lua for an example
-- Add gates to c/c++ header files
local function insert_gates()
    local gatename = vim.fn.expand("%:t"):upper():gsub("%.", "_")
    vim.api.nvim_command("normal! i#ifndef " .. gatename)
    vim.api.nvim_command("normal! o#define " .. gatename)
    vim.api.nvim_command("normal! o")
    vim.api.nvim_command("normal! Go#endif /* " .. gatename .. " */")
    vim.api.nvim_command("normal! ^k")
end
vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.{h,hpp}",
    callback = function() insert_gates() end
})
