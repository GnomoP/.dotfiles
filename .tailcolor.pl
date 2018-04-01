LINE:
  while (<>) {
    my $commitname = `whoami | tr -d '\n'`.'@'.`hostname | tr -d '\n'`.' \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}';

    if (m/^\[master [A-Za-z0-9]+\] $commitname\s+$/) {
        s/\[master [A-Za-z0-9]+\]/\e[1;34m$&\e[m/g;
                    s/$commitname/\e[0;31m$&\e[m/g;
        next;
    }

    if (m/^\s+[A-Za-z0-9]+\.\.[A-Za-z0-9]+\s+master -> master/) {
        s/[A-Za-z0-9]+\.\.[A-Za-z0-9]+/\e[1;33m$&\e[m/g;
        s/master/\e[0;34m$&\e[m/g;
            s/->/\e[1;32m$&\e[m/g;
        next;
    }

    #if (m/a/) {
      #
      #
      #
    #}

    if (m/('?master'?)|('?origin'?)/) {
        s/'?master'?/\e[1;34m$&\e[m/g;
        s/'?origin'?/\e[1;34m$&\e[m/g;
    }

    if (m/$commitname/) {
           s/$commitname/\e[1;31m$&\e[m/g;
    }
  } continue {
    print or die "-p destination: $!\n";
  }
