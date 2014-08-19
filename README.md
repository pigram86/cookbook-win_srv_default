Description
===========
This cookbook is used for install default Roles and Features for base builds of Windows Server 2008 R2, Windows Server 2012 and Windows Server 2012 R2.


Supported Platforms
===================

* Windows Server 2008 R2
* Windows Server 2012
* Windows Server 2012 R2


Cookbooks
=========

* windows
* powershell

Recipes
=======

windows_server_default::default.rb
----------------------------------
* case node['platform_version']
* when "6.3.9600"
*   include_recipe "windows_server_default::w2012r2"
* when "6.2.9200"
*   include_recipe "windows_server_default::w2012"
* when "6.1.7601"
*   include_recipe "windows_server_default::w2k8r2"
* end

windows_server_default::w2012.rb
--------------------------------
* %w{ File-Services CoreFileServer  WindowsServerBackup NetFx3ServerFeatures NetFx3 ServerManager-Core-RSAT ServerManager-Core-RSAT-Role-Tools  RSAT-AD-Tools-Feature RSAT-ADDS-Tools-Feature }.each do |feature|
*  windows_feature feature do
*    action :install
*    not_if {reboot_pending?}
*  end
* end

* windows_reboot 60 do
*   reason "Chef said to"
*   only_if {reboot_pending?}
* end

windows_server_default::w2012r2.rb
----------------------------------
* %w{ File-Services CoreFileServer  WindowsServerBackup NetFx3ServerFeatures NetFx3 ServerManager-Core-RSAT ServerManager-Core-RSAT-Role-Tools RSAT-AD-Tools-Feature RSAT-ADDS-Tools-Feature }.each do |feature|
*  windows_feature feature do
*    action :install
*    not_if {reboot_pending?}
*  end
* end


* windows_reboot 60 do
*   reason 'Chef said to'
*   only_if {reboot_pending?}
* end

windows_server_default::w2k8r2.rb
---------------------------------
* powershell_script "default" do
*   code <<-EOH
*   Import-Module ServerManager
*   Add-WindowsFeature FS-FileServer
*   Add-WindowsFeature Backup
*   Add-WindowsFeature Backup-Tools
*   Add-WindowsFeature Net-Framework-Core
*   Add-WindowsFeature Powershell-ISE
*   Add-WindowsFeature WSRM
*   Add-WindowsFeature GPMC
*   EOH
*   not_if {reboot_pending?}
* end

* powershell_script "default" do
*   code <<-EOH
*   Import-Module ServerManager
*   Add-WindowsFeature RSAT-AD-Tools
*   EOH
*   not_if {reboot_pending?}
* end

* powershell_script "default" do
*   code <<-EOH
*   Import-Module ServerManager
*   Add-WindowsFeature RSAT-AD-PowerShell
*   EOH
*   not_if {reboot_pending?}
* end

* powershell_script "default" do
*   code <<-EOH
*   Import-Module ServerManager
*   Add-WindowsFeature RSAT-ADDS-Tools
*   EOH
*   not_if {reboot_pending?}
* end

* powershell_script "default" do
*   code <<-EOH
*   Import-Module ServerManager
*   Add-WindowsFeature RSAT-ADLDS
*   EOH
*   not_if {reboot_pending?}
* end

* windows_reboot 60 do
*   reason 'Chef Pigram said to'
*   only_if {reboot_pending?}
* end

Usage
=====

windows_server_default::default.rb
----------------------------------

* Include `windows_server_default` in your node's `run_list`:

```json
 {
  "run_list": [
    "recipe[windows_server_default::default]"
   ]
 }
 ```

  Contributing
=============

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

License and Authors
===================

Author:: Todd Pigram (<todd@toddpigram.com>)

Copyright:: 2013-2014, Todd Pigram

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

