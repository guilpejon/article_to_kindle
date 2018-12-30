require 'pony'

Pony.mail(:to => 'you@gmail.com', :from => 'me@gmail.com', :subject => 'hi', :body => 'Hello there.')
