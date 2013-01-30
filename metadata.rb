name             "tk-demo"
maintainer       "Bryan W. Berry"
maintainer_email "bryan.berry@gmail.com"
license          "Apache V2"
description      "Installs/Configures tk-demo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ rvm yum  }.each do |ckbk|
  depends ckbk
end
