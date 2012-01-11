#!/usr/bin/env ruby -w
# vim: ai et sts=2 sw=2 syn=ruby

# shell scripts cannot run interactively as a git-hook, so we're circumventing
# this by using Ruby.

def die(msg, code=1)
  puts msg
  exit code
end

current_author, current_email=`git var GIT_AUTHOR_IDENT`.split[0..1]

die "You can't be #{current_author}. Please set your username with git-config" if [ENV["SUDO_USER"], ENV["USER"], "tworker"].compact.include? current_author
die "Your email can't start with 'tworker'. Please set your email with git-config" if current_email.start_with? "tworker"

print "Current developer is set to: #{current_author} #{current_email}.\n  Is this ok? [y/n] "
answer = File.new("/dev/tty").readline.chomp.downcase

die "ABORT: Please set your username and email with git-config." unless answer == "y"
