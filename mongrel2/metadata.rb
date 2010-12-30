maintainer       "RAM9"
maintainer_email "curtis@robotarmyma.de"
license          "All rights reserved"
description      "Installs/Configures mongrel2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe "mongrel2" , "mongrel 2"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends "sqlite"

attribute "ram/op",
  :display_name => 'operations dir',
  :dscription => 'operations dir',
  :default => '/op'

attribute "zeromq/version",
  :display_name => "ZeroMQ version",
  :description => "Which ZerqMQ version will be installed",
  :default => "2.0.10"

attribute "zeromq/checksum",
  :display_name => "ZeroMQ Source Checksum",
  :description => "Which ZerqMQ version will be installed",
  :default => "ab794a174210b9e8096a4efd1d1a4d42"

attribute "zeromq/source",
  :display_name => "ZeroMQ Source"

attribute "mongrel/version",
  :display_name => "mongrel2 version",
  :description => "Which mongrel2 version will be installed",
  :default => "1.4"

attribute "mongrel/checksum",
  :display_name => "mongrel Source Checksum",
  :description => "Source Checksum",
  :default => "d5b917c7cb2fd0527f6824edda37cefb"

attribute "mongrel/source",
  :display_name => "Mongrel2 Source"


