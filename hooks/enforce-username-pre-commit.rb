#!/usr/bin/env ruby -w
# vim: ai et sts=2 sw=2 syn=ruby

# shell scripts cannot run interactively as a git-hook, so we're circumventing
# this by using Ruby.

def die(msg, code=1)
  puts red(msg)
  exit code
end

def red(msg)
  "#{`tput setaf 1`}#{msg}#{`tput sgr0`}"
end

def green(msg)
  "#{`tput setaf 2`}#{msg}#{`tput sgr0`}"
end

`git var GIT_AUTHOR_IDENT` =~ /^([^<]+)<([^>]+)/
current_author, current_email = $1.strip, $2.strip

die "You can't be #{current_author}. Please set your username with git-config" if [ENV["SUDO_USER"], ENV["USER"], "tworker"].compact.include? current_author
die "Your email can't start with 'tworker'. Please set your email with git-config" if current_email.start_with? "tworker"

print %Q{
Current developer is set to: #{green current_author} <#{green current_email}>
  Is this ok? [y/n]: }

answer = File.new("/dev/tty").readline.chomp.downcase

die "ABORT: Please set your username and email with git-config." unless answer == "y"
