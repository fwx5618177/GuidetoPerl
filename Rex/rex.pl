#!/usr/bin/perl -w

use Rex;
use Rex::Commands::Run;
use Rex::Commands::Fs;
use Rex::Group::Entry::Server;

Rex::connect(
  server    => "120.78.181.172",
  user      => "fwx",
  password   => "fwx5618177.",
#   private_key => "/path/to/private/key/file",
#   public_key  => "/path/to/public/key/file",
);
 
if(is_file("/foo/bar")) {
  print "Do something...\n";
}

print "start";
 
# my $output = run("uptime");