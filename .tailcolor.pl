LINE:
  while (<>) {
    my $commitname = `whoami | tr -d '\n'`.'@'.`hostname | tr -d '\n'`.' \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}';

    if (m/\[master [A-Za-z0-9]+\] $commitname$/) {
        s/\[master [A-Za-z0-9]+\]/\e[1;34m$&\e[m/;
                    s/$commitname/\e[0;31m$&\e[m/;
    }
    elsif (m/$commitname/) {
           s/$commitname/\e[1;31m$&\e[m/;
    }
  } continue {
    print or die "-p destination: $!\n";
  }
