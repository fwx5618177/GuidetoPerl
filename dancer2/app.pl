#!/usr/bin/perl -w

use Dancer2;

get '/' => sub {
    return "hello World!";
};

get '/ge' => sub {
    return "hi ge";
};

start;