use strict;
use warnings;

LINE:
  while (<>) {
    # For a table of colors, see color-codes

    # Bash verbose output
    s{(^\++.*)}{\e[1;37;41m$1\e[m}ag and next;

    # TODO get actual 'whoami' and 'hostname' outputs
    if ( m{ ^\s*
        ( \[master\ [a-z0-9]{7,}\] )
      | ( root\@kali-kezio\ \d{4}-\d{2}-\d{2}\ \d{2}:\d{2}:\d{2} )
            \s*$}ax )
    {
      s{ ( \[master\ [a-z0-9]{7,}\] )
       \ (root\@kali-kezio\ \d{4}-\d{2}-\d{2}\ \d{2}:\d{2}:\d{2} ) }
       {\e[1;34m$1 \e[1;31m$2\e[m}agx;

      next;
    }

    if ( m{ ^\s* ( \d+\ files?\ changed )|
                 ( \d+\ deletions?\(-\) )|
                 ( \d+\ insertions?\(\+\) ) \s*$ }ax )
    {
      s{ ( \d+ )\ ( files?\ changed,? ) }
       {\e[1;36m$1 \e[0;36m$2 \e[m}agx;

      s{ ( \d+ )\ ( deletions? \( ) (-) ( \) ,? ) }
       {\e[1;31m$1 \e[0;31m$2\e[1;31m$3\e[0;31m$4\e[m}agx;

      s{( \d+ )\ ( insertions? \( ) (\+) ( \),? ) }
       {\e[1;32m$1 \e[0;32m$2\e[1;32m$3\e[0;32m$4\e[m}agx;

      next;
    }

    if ( m{ ^\s* rewrite .* \ \( \d+ % \) }x )
    {
      # Match the inverse of m{ ( \d{2}% ) | ( rewrite ) }ax
      s{ (^\s* rewrite\ ) ( .* ) ( \( \d+ % \) \s+$ ) }
       {\e[1;32m$1\e[0;32m$2\e[1;31m$3\e[m}ax;
      #{\e[1;35m$&\e[m}ax;

      next;
    }

    if ( m{ ^\s* To\  (https?://.*)|(git\+ssh://git\@github\.com/.*) }x )
    {
      s{ ( ^To\  ) ( .* ) }
       {\e[1;37m$1\e[4;36m$2\e[m}ax
    }

    if ( m{ ^\s* [a-z0-9]{7,} \.\. [a-z0-9]{7,} \ {2}
            \S+ \ -> \ \S+ \s*$ }x )
    {
      s{ ( [a-z0-9]{7,} ) \.\. ( [a-z0-9]{7,} ) }
       {\e[1;33m$1 ... $2\e[m}ax;

      s{ ( \S* ) \s+ ( -> ) \s+ ( \S* ) }
       {\e[0;34m$1 \e[1;32m$2 \e[0;34m$3\e[m}ax;
    }

   #
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
