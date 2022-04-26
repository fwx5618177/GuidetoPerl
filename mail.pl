#!/usr/bin/perl -w

use strict;
use MIME::Lite;

# mail
my $to = '279357596@qq.com';
my $from = 'no-reply@moxi.com';

my $subject = 'No reply';
# $message = 'We already received your mail, and we will take some time to read it. We will contact with you. Looking forward to your reply.';
my $message = '<h1>This is one letter from Perl. <p>You could click this <a href="http://moxixii.com">moxi</a></p></h1>';

# open(MAIL, "|/usr/sbin/sendmail -t");
# print MAIL "To: $to\n";
# print MAIL "From: $from\n";
# print MAIL "Subject: $subject\n\n";
# print MAIL "Content-type: text/html\n";
# print MAIL $message;

# close(MAIL);
# print "already send thie mail.\n";

my $msg = MIME::Lite->new(
    From => $from,
    To => $to,
    Subject => $subject,
    Type => 'multipart/mixed',
    Data => $message,
);

$msg->attr("content-type" => "text/html");

$msg->attach(
    Type => "TEXT",
    Data => $message,
);
$msg->attach(
    Type => 'TEXT',
    Path => './data.txt',
    Filename => 'data.txt',
    Disposition => 'attachment'
);

$msg->send;

print "already send thie mail.\n";
