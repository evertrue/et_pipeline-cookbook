
jenkins_plugin 'simple-theme-plugin' do
  notifies :restart, 'service[jenkins]'
end

template '/var/lib/jenkins/org.codefirst.SimpleThemeDecorator.xml' do
  source 'org.codefirst.SimpleThemeDecorator.xml.erb'
  owner 'jenkins'
  group 'jenkins'
  mode '0744'
  notifies :restart, 'service[jenkins]'
end
