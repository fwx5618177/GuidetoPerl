#!/usr/bin/perl -w

use strict;
use Email::Sender::Simple qw(sendmail);
use Email::MIME;
use Email::Stuffer;

my $to = 'fengwenxuan2006@126.com';
my $from = 'no-reply@moxi.com';

my $subject = 'No reply';
# $message = 'We already received your mail, and we will take some time to read it. We will contact with you. Looking forward to your reply.';
my $message = '<h1>This is one letter from Perl. <p>You could click this <a href="http://moxixii.com">moxi</a></p></h1>';

# Prepare the message
my $body = <<'AMBUSH_READY';
Dear Santa
 
I have killed Bun Bun.
 
Yes, I know what you are thinking... but it was actually a total accident.
 
I was in a crowded line at a BayWatch signing, and I tripped, and stood on
his head.
 
I know. Oops! :/
 
So anyways, I am willing to sell you the body for $1 million dollars.
 
Be near the pinhole to the Dimension of Pain at midnight.
 
Alias
 
AMBUSH_READY
 
# Create and send the email in one shot
Email::Stuffer->from     ($fro)
              ->to       ($to)
              ->bcc      ('279357596@qq.com')
              ->text_body($body)
              # ->attach_file('dead_bunbun_faked.gif' )
              ->send;