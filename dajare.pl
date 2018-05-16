#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use utf8;
use Encode;

my $input = $ARGV[0];
$input =~ s/['`\\\s\n\r、。]//g;

my $output = `echo '$input' | kakasi -JH -i utf8`;

$output = decode_utf8 $output;
$output =~ s/[^ぁ-んァ-ン]//g;
$output =~ tr/ァ-ン/ぁ-ん/;
$output =~ tr/ぁぃぅぇぉ/あいうえお/;
$output =~ tr/ゃゅょ/やゆよ/;
$output =~ s/っ//g;
$output =~ s/う/お/g;
$output =~ s/を/お/g;
$output =~ s/へ/え/g;
$output =~ s/わ/は/g;

#say encode_utf8 $output;

my @sp = split(//, $output);
my $len = $#sp;
my $max =0;
for my $i(1 .. $len){
  my $cou=0;
  for my $ii($i .. $len){
    if($sp[$ii-$i] eq $sp[$ii]){
      $cou++;
      $max=$cou if($max < $cou);
    }else{
      $cou=0;
    }
  }
}
say (($max * $max / ($len+1))*20);
