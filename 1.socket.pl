#!/usr/bin/perl -W

use strict;

# Socket
use Socket;

my $port = 12345;
my $proto = getprotobyname('tcp');
my $server_id_address = "localhost";

socket(SOCKET,PF_INET,SOCK_STREAM, $proto);
setsockopt(SOCKET, SOL_SOCKET, SO_REUSEADDR, 1);

bind(SOCKET, pack_sockaddr_in($port, inet_aton($server_id_address)))
or die "无法绑定端口\n";

listen(SOCKET, 5) or die "Listen: $!";

print "访问启动: http://$server_id_address:12345\n";

my $client_addr;

while ($client_addr = accept(NEW_SOCKET, SOCKET)) {
    my $name = gethostbyaddr($client_addr, AF_INET);

    print NEW_SOCKET "server infos";
    print "Connection: $name\n";

    close NEW_SOCKET;
}