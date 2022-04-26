#!/usr/bin/perl -W

print "Hello World!\n";
print 'Hello World!\n';

=pod
多行注释
=cut

$a = 10;
print "\na = $a\n";
print 'a = $a\n';

# Here doc
$var = <<"EOF";
a = $a
asda
EOF

print "\nvar = $var\n";

$firstVal = 123;
@arr = (1,2,3);
%hashVal = ('a' => 1, 'b' => 2);
print "arr = @arr\n @arr[0]\n";
print "hashVal = $hashVal{'a'}\n";

print "\a";

@copy = @arr;
$size = @arr;
print "arr: @arr, size: $size\n";

$str1 = "hello" . "world";
print "str1: $str1\n";

# 特殊字符
print "fileName:" . __FILE__ . "\n" . "line:" . __LINE__ . "\n" . "package:" . __PACKAGE__ . "\n";

# 一个以 v 开头,后面跟着一个或多个用句点分隔的整数,会被当作一个字串文本
$smile = v77;
print "v str: $smile \n";

@arrStr = qw/is a e/;
$sizeStr = @arrStr;
print "arr str: @arrStr\n";

$status = ($sizeStr > 2) ? "有" : "无";
print "status = $status";

sub printSayHi{
    print "\nsub function: Hello\n";
}

printSayHi();

# 参数
sub hi{
    my @n = @_;
    print "params : @n\n";
}

hi(1,2,3);

sub printHash {
    my (%hash) = @_;

    foreach my $key (keys %hash) {
        my $value = $hash{$key};
        print "$key : $value\n";
    }
}

printHash(('name' => 'fwx', 'age' => 1));

sub reSum {
    return $_[0] + $_[1];
}

print reSum(1,2) . "\n";

# local
$loStr = "Hi";


use feature 'state';
sub printLocalStr {
    local $loStr = "s";
    state $count = 0;

    print "printLocalStr: $loStr\n" . " count: $count\n";
}

printLocalStr();

print "localStr: $loStr\n";

# reference
$foo = "test";
$scalarref = \$foo;

print "ref:" . $scalarref . "\ncancel refs:" . $$scalarref . "\n";

sub printRef {
    print "print ref";
}
printRef();

$cref = \&printRef;
print "sub printRef:" . $cref . "\nsub ref:" . &$cref() . "\n";


# 格式化输出
$text = "google runoob taobao";
format STDOUT =
first: ^<<<<<  # 左边对齐，字符长度为6
    $text
second: ^<<<<< # 左边对齐，字符长度为6
    $text
third: ^<<<< # 左边对齐，字符长度为5，taobao 最后一个 o 被截断
    $text  
.
write;

# file
open(DATA, '+>>data.tmp') or die "Files doesn't exist, \n err: $i";

close(DATA);

# regex
$bar = "I am one front-end engineer.";
if ($bar =~ /one/) {
    print "one\n";
} else {
    print "don't match\n";
}

# mail
$to = 'fengwenxuan2006@126.com';
$from = 'no-reply@moxi.com';

$subject = 'No reply';
# $message = 'We already received your mail, and we will take some time to read it. We will contact with you. Looking forward to your reply.';
$message = '<h1>This is one letter from Perl. <p>You could click this <a href="http://moxixii.com">moxi</a></p></h1>';

$body = <<'AMBUSH_READY';
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

# open(MAIL, "|/usr/sbin/sendmail -t");
# print MAIL "To: $to\n";
# print MAIL "From: $from\n";
# print MAIL "Subject: $subject\n\n";
# print MAIL "Content-type: text/html\n";
# print MAIL $message;

# close(MAIL);
# print "already send thie mail.\n";

use MIME::Lite;

$msg = MIME::Lite->new(
    From => $from,
    To => $to,
    Subject => $subject,
    Type => 'multipart/mixed',
    Data => $message,
    Data => $body,
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
