function comp -a target
  if not which zstd
    echo 'zstd not in $PATH. Please ensure zstd is installed and available.'
    exit 1
  end
  if test -d $target
    # TODO: Confirm if user wants to remove source
    tar cf - $target | zstd > "$target.tar.zst" \
    && /bin/rm -rf $target \
    || echo "comp $target was unsuccessful"
  else if test -f $target
    zstd $target && /bin/rm -i $target
  end
end
