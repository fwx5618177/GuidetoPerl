#!/usr/bin/perl -w

my $text = << 'EOF';
adawd
asdad
adad
adad
# Hi

> hi1

EOF


# use Text::Markdown 'markdown';
# my $html = markdown($text);

 
# use Text::Markdown 'markdown';
# my $html = markdown( $text, {
#     empty_element_suffix => '>',
#     tab_width => 2,
# } );
 
# use Text::Markdown;
# my $m = Text::Markdown->new;
# my $html = $m->markdown($text);
 
use Text::Markdown;
use Text::MultiMarkdown;
my $m = Text::MultiMarkdown->new(
    empty_element_suffix => '>',
    tab_width => 2,
);
my $html = $m->markdown( $text );


print $html;