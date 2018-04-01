LINE:
  while (<>) {
    # For a table of colors, see color-codes

    # Bash verbose output
    s{
      (^\++.*)
    }{
      \e[1;37;41m$1  # Bold white on Red BG
      \e[m
    }agx and next;

    # TODO get actual 'whoami' and 'hostname' outputs
    s{
      ( \[master\ [a-z0-9]{7,}\] )|
      ( root\@kali-kezio\ \d{4}-\d{2}-\d{2}\ \d{2}:\d{2}:\d{2} )
    }{\e[1;34m$1\e[1;31m$2\e[m}agx and next;

    m{
      ( \d+\ files?\ changed )|
      ( \d+\ deletions?\(-\) )|
      ( \d+\ insertions?\(\+\) )
    }ax and
    s{
      ( \d+ )\ ( files?\ changed,? )
    }{\e[1;36m$1 \e[0;36m$2 \e[m}agx and
    s{
      ( \d+ )\ ( deletions? \( (-) \) (,\ )? )
    }{\e[1;31m$1 \e[0;31m$2 \e[1;31m$3 \e[0;31m$4\e[m}agx and
    s{
      ( \d+ )\ ( insertions? \( (\+) \) (,\ )? )
    }{\e[1;32m$1 \e[0;32m$2 \e[1;32m$3 \e[0;32m$4\e[m}agx and next;

    if (m/^\s+[A-Za-z0-9]+\.\.[A-Za-z0-9]+\s+master -> master/) {
      s/([A-Za-z0-9]+\.\.[A-Za-z0-9]+)/\e[1;33m\1\e[m/g;
                            s/(master)/\e[0;34m\1\e[m/g;
                                s/(->)/\e[1;32m\1\e[m/g;
      next;
    }

   #if (m/('?master'?)|('?origin'?)/) {
   #  s/('?master'?)/\e[1;34m\1\e[m/g;
   #  s/('?origin'?)/\e[1;34m\1\e[m/g;
   #}

   #if (m/\W*$commitname\W*/) {
   #  s/(\W*$commitname\W*)/\e[1;31m\1\e[m/g;
   #}
  } continue {
    print or die "-p destination: $!\n";
  }
