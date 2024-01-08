vim.cmd([[
  function! DisableExtras()
    call nvim_win_set_option(g:float_preview#win, 'number', v:false)
    call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
    call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
  endfunction

  autocmd User FloatPreviewWinOpen call DisableExtras()
]])
