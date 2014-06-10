# windows_server_default cookbook
This cookbook is used for install default Roles and Features for base builds of Windows Server 2008 R2, Windows Server 2012 and Windows Server 2012 R2.


# Requirements
depends on windows cookbook

# Usage
Assign the default recipe to the nodes run list and if the platform version macthes it will run the correct recipe

# Attributes

# Recipes
windows_server_default::default.rb

case node['platform_version']
when "6.3.9600"
  include_recipe "windows_server_default::w2012r2"
when "6.2.9200"
  include_recipe "windows_server_default::w2012"
when "6.1.7601"
  include_recipe "windows_server_default::w2k8r2"
end

windows_server_default::w2012.rb

%w{ File-Services CoreFileServer  WindowsServerBackup NetFx3ServerFeatures NetFx3 ServerManager-Core-RSAT ServerManager-Core-RSAT-Role-Tools  RSAT-AD-Tools-Feature RSAT-ADDS-Tools-Feature }.each do |feature|
  windows_feature feature do
    action :install
    not_if {reboot_pending?}
  end
end

windows_reboot 60 do
  reason "Chef said to"
  only_if {reboot_pending?}
end

windows_server_default::w2012r2.rb

%w{ File-Services CoreFileServer  WindowsServerBackup NetFx3ServerFeatures NetFx3 ServerManager-Core-RSAT ServerManager-Core-RSAT-Role-Tools RSAT-AD-Tools-Feature RSAT-ADDS-Tools-Feature }.each do |feature|
  windows_feature feature do
    action :install
    not_if {reboot_pending?}
  end
end


windows_reboot 60 do
  reason 'Chef said to'
  only_if {reboot_pending?}
end

windows_server_default::w2k8r2.rb

powershell_script "default" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature FS-FileServer
  Add-WindowsFeature Backup
  Add-WindowsFeature Backup-Tools
  Add-WindowsFeature Net-Framework-Core
  Add-WindowsFeature Powershell-ISE
  Add-WindowsFeature WSRM
  Add-WindowsFeature GPMC
  EOH
 not_if {reboot_pending?}
end

powershell_script "default" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature RSAT-AD-Tools
  EOH
  not_if {reboot_pending?}
end

powershell_script "default" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature RSAT-AD-PowerShell
  EOH
  not_if {reboot_pending?}
end

powershell_script "default" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature RSAT-ADDS-Tools
  EOH
  not_if {reboot_pending?}
end

powershell_script "default" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature RSAT-ADLDS
  EOH
  not_if {reboot_pending?}
end

windows_reboot 60 do
  reason 'Chef Pigram said to'
  only_if {reboot_pending?}
end

# Author

Author:: Todd Pigram (<todd@toddpigram.com>)
