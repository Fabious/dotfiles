function fish_user_key_bindings
    fzf_key_bindings

    # Ctrl + T
    # 2>/dev/null removes the Send job X, “PROGRAM” to foreground message, omit that if you wish to keep it.
    # commandline -f repaint tells fish to redraw the prompt to avoid weird cursor position issues.
    bind \ct 'fg 2>/dev/null; commandline -f repaint'
end
