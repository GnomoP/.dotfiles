use strict;
use warnings;

my $name = `whoami`.'\@'.`hostname`;

LINE:
  while (<>) {
    # For a table of colors, see color-codes

    # Bash verbose output
    s{(^\++.*)}{\e[1;37;41m$1\e[m}ag and next;

    # TODO get actual 'whoami' and 'hostname' outputs
    if ( m{ ^\s*
        ( \[master\ [a-z0-9]{7,}\] )
      | ( $name\ \d{4}-\d{2}-\d{2}\ \d{2}:\d{2}:\d{2} )
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
       {\e[1;36m$1 \e[0;36m$2\e[m}agx;

      s{ ( \d+ )\ ( deletions? \( ) (-) ( \) ,? ) }
       {\e[1;31m$1 \e[0;31m$2\e[1;31m$3\e[0;31m$4\e[m}agx;

      s{ ( \d+ )\ ( insertions? \( ) (\+) ( \),? ) }
       {\e[1;32m$1 \e[0;32m$2\e[1;32m$3\e[0;32m$4\e[m}agx;

      next;
    }

    if ( m{ ^\s* rewrite .* \ \( \d+ % \) }x )
    {
      s{ (^\s* rewrite )\ ( .* )\ ( \( \d+ % \) \s+$ ) }
       {\e[1;32m$1 \e[0;33m$2 \e[1;31m$3\e[m}ax;

      next;
    }

    if ( m{ ^\s* create\ mode\ \d+ }x )
    {
      s{ ( ^\s* create )\ ( mode )\ ( \d+ )\ ( .* ) }
       {\e[1;32m$1 \e[0;32m$2 $3 \e[0;33m$4\e[m}ax;

      next;
    }

    if ( m{ ^\s* rename\ .*\ \( \d+ % \) }x )
    {
      s{ ( ^\s* rename )\ ( .* )\ ( \( \d+ % \) ) }
       {\e[1;32m$1 \e[0;33m$2 \e[1;31m$3\e[m}ax;

      s{ ( \{\ =>\ ) ( .* ) ( \} ) }
       {\e[1;33m$1\e[4;33m$2\e[m\e[1;33m\}\e[0;33m}ax;

       next;
    }

   #if ( m{ ^Counting\ objects:\ \d+ ,\ done\. }x )
   #{
   #  s{ ( \d+ )|( \D* ) }
   #   {}ax;
   #}

    if ( m{ ^\s* To\  (https?://)|(git\+ssh) }x )
    {
      s{ ( ^\s* To\  ) ( .*$ ) }
       {\e[1;37m$1\e[4;36m$2\e[m}ax;

      next;
    }

    if ( m{ ^\s* [a-z0-9]{7,} \.\. [a-z0-9]{7,} \ {2}
            \S+ \ -> \ \S+ \s*$ }x )
    {
      s{ ( [a-z0-9]{7,} ) \.\. ( [a-z0-9]{7,} ) }
       {\e[1;33m$1 ... $2\e[m}ax;

      s{ ( \S* ) \s+ ( -> ) \s+ ( \S* ) }
       {\e[0;34m$1 \e[1;32m$2 \e[0;34m$3\e[m}ax;

      next;
    }

    s{ ( '?master'? )|( '?origin'? ) }
     {\e[1;34m$&\e[m}agx;

    s{ ( '? ( \./ )? $name\ \d{4}-\d{2}-\d{2}\ \d{2}:\d{2}:\d{2} '? ) }
     {\e[1;31m$1\e[m}agx;

  } continue {
    print "+ $_" or die "-p destination: $!\n";
  }
# vim: syntax=perl
# vim: set ts=2 sw=2 tw=80 et :
