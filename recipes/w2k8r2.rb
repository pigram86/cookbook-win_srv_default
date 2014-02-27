#
# Cookbook Name:: windows_server_default
# Recipe:: w2k8r2
#
# Copyright (C) 2014 Todd Pigram
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "windows::reboot_handler"

powershell "default" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature FS-FileServer
  Add-WindowsFeature Backup
  Add-WindowsFeature Backup-Tools
  Add-WindowsFeature Net-Framework-Core
  Add-WindowsFeature Powershell-ISE
  Add-WindowsFeature WSRM
  Add-WindowsFeature GPMC
  Add-WindowsFeature RSAT-AD-Tools
  Add-WindowsFeature RSAT-AD-PowerShell
  Add-WindowsFeature RSAT-ADDS-Tools
  Add-WindowsFeature RSAT-ADLDS
  EOH
  not_if {reboot_pending?}
end

windows_reboot 60 do
  reason 'Chef Pigram said to'
  only_if {reboot_pending?}
end
