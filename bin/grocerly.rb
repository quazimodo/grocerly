#!/usr/bin/env ruby

libdir = File.expand_path('../../lib/', __FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'grocerly.rb'

Grocerly.run(ARGV)
