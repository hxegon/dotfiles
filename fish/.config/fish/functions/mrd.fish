# "Most Recent Download", gives the past for the most recently added file in ~/Downloads
function mrd
  echo ~/Downloads/(ls -t ~/Downloads | head -n 1)
end
