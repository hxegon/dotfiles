function comp -a target
  if test -d $target
    # TODO: Confirm if user wants to remove source
    tar cf - $target | zstd > "$target.tar.zst" \
    && /bin/rm -rf $target \
    || echo 'comptarget was unsuccessful'
  else if test -f $target
    zstd $target && /bin/rm -i $target
  end
end
