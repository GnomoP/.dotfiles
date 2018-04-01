LINE:
  while (<>) {
    my $commitname = `whoami | tr -d '\n'`.'@'.`hostname | tr -d '\n'`.' \d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}';
    if (m/\[master \d+\] $commitname/) {
        s/\[master \d+\] $commitname/\e[1;34m$&\e[m/g;
    }
    elsif (m/$commitname/) {
           s/$commitname/\e[1;31m$&\e[m/g;
    }
  } continue {
    print or die "-p destination: $!\n";
  }
