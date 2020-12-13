function decomp -a target
  if not which zstd
    echo 'zstd not in $PATH. Please ensure zstd is installed and available.'
    exit 1
  end

  if not test -f $target
    echo "$comf is not a file!"
    exit 1
  end

  set ext (echo $target | sed 's/^[^.]*//')
  if test $ext = '.zst'
    zstd -d $target && /bin/rm -i $target
  else if test $ext = '.tar.zst'
    zstdcat $target | tar xf - && /bin/rm -i $target
  else
    echo "decomp cannot handle files with extension $ext"
    exit 1
  end
end
