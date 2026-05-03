function cd
  if command -q zoxide
    z $argv
  else
    builtin cd
  end
end
