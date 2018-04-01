LINE:
  while (<>) {
    my $commitname = `whoami | tr -d '\n'`.'@'.`hostname | tr -d '\n'`.' \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}';

    if (m/\++/) { next; }

    if (m/^\[master [A-Za-z0-9]+\] $commitname\s+$/) {
      s/(\[master [A-Za-z0-9]+\])/\e[1;34m\1\e[m/g;
                  s/($commitname)/\e[1;31m\1\e[m/g;
      next;
    }

    if (m/((\d+) file(s)? changed(, )?)|(\d+ insertion(s)?\(\+\)(, )?)|(\d+ deletion(s)?\(-\)(, )?)/) {
      print "Matchd, bish\n";
      s/((\d+) insertions?\(\+\)(, )?)/\e[32m\1\2\e[m/g; # 32m
        s/((\d+) deletions?\(-\)(, )?)/\e[31m\1\2\e[m/g; # 31m
         s/((\d+) files? changed(, )?)/<g1>\1<\/g1><g2>\2<\/g2>/g; # 36m
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
