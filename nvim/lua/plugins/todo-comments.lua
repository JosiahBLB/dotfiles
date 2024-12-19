-- Highlight todo, notes, etc in comments
-- TODO:
-- HACK:
-- WARN:
-- PERF:
-- OPTIM:
-- PERFORMANCE:
-- OPTIMIZE:
-- NOTE:
-- INFO:
-- TESTING:
-- PASSED:
-- FAILED:
-- TEST:
-- FIX:
-- FIXME:
-- BUG:
-- FIXIT:
-- ISSUE:
return {
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
-- vim: ts=2 sts=2 sw=2 et
