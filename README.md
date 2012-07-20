stacktrace-enhancer
===================

Stacktrace dump enhancer for CoffeeScript Node.js programs.
It prints compiled javascript content along with stacktrace dump.

Example usage:

nodemon file.coffee 2>&1 | ./stacktrace_enhancer.rb

if you want to filter only stderr (recommended), you can use following:

nodemon file.coffee 3>&1 1>&2 2>&3 3>&- | ./stacktrace_enhancer.rb

