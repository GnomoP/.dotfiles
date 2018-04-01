LINE:
  while (<>) {
    my $commitname = `whoami | tr -d '\n'`.'@'.`hostname | tr -d '\n'`.' \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}';
    my $lastcommit = `whoami | tr -d '\n'`.'@'.`hostname | tr -d '\n'`.' \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}';

    # For a table of colors, see color-codes

    # Bash verbose output
    s{
      (^\++.*)
    }{
      \e[1;37;41m$1  # Bold white on Red BG
      \e[m
    }ax and next;

    s{
      (^
      \[master\ \w+\]
      \s+)
      ($commitname
      \s+
      $)
    }{
      \e[1;34m$1  # Bold Blue on BG
      \e[2;31m$2  # Bold Red on BG
      \e[m
    }ax and next;

    if (m/(\d+ file(s)? changed(, )?)|(\d+ insertion(s)?\(\+\)(, )?)|(\d+ deletion(s)?\(-\)(, )?)/) {
     #s/((\d+) insertion(s)?(\(\+\))(, )?)/\e[1;32m\2\e[32m\1\e[m/g;
      s/((\d+) insertion(s)?\((\+)\)(, )?)/\e[1;32m\2\e[0;32m insertion\3\(\e[4;32m\4\e[0;32m\)\5\e[m\6/g;
      #
      ##
      ##
        s/((\d+) deletion(s)?(\(-\))(, )?)/\e[1;31m\2\e[31m\1\e[m/g;
         s/((\d+) file(s)? changed(, )?)/\e[36m\1\e[m/g;
      next;
    }

    if (m/^\s+[A-Za-z0-9]+\.\.[A-Za-z0-9]+\s+master -> master/) {
      s/([A-Za-z0-9]+\.\.[A-Za-z0-9]+)/\e[1;33m\1\e[m/g;
                            s/(master)/\e[0;34m\1\e[m/g;
                                s/(->)/\e[1;32m\1\e[m/g;
      next;
    }

    if (m/('?master'?)|('?origin'?)/) {
      s/('?master'?)/\e[1;34m\1\e[m/g;
      s/('?origin'?)/\e[1;34m\1\e[m/g;
    }

    if (m/\W*$commitname\W*/) {
      s/(\W*$commitname\W*)/\e[1;31m\1\e[m/g;
    }
  } continue {
    print or die "-p destination: $!\n";
  }
