execute 'download RVM GPG key' do
  user 'deployer'
  environment 'HOME' => '/home/deployer'
  command 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
end
