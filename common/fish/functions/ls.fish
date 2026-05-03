function ls
  if command -q eza
    eza --color=auto --icons=auto --no-quotes $argv
  else
    command ls $argv
  end
end
