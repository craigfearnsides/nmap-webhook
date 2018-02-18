#!/usr/bin/env perl
use strict;
use warnings;
use Dancer2;
use Nmap::Parser;

set serializer => 'JSON';
set engines =>
  { serializer => { JSON => { allow_blessed => 1, convert_blessed => 1 } } };
my $np = new Nmap::Parser;

sub TO_JSON { return { %{ shift() } }; }

get '/:ip' => sub {
    pass
      if route_parameters->get('ip') !~
/^((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])|(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)+([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]))$/;

    $np->purge();

    my @ip = route_parameters->get('ip');
    $np->parsescan(
        '/usr/bin/nmap',
        ' --min-parallelism 20'
          . ' -sSU '
          . ' -p T:80-81,T:222,T:440-443,T:800-801,T:1080,T:3128,T:8080,T:53,U:53,U:500,U:4500,U:1194',
        @ip
    );

    return TO_JSON $np->all_hosts();

};

dance;
