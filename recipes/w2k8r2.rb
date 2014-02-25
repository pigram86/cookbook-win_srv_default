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

%w{ FS-FileServer Backup Backup-Tools Net-Framework-Core Powershell-ISE WSRM GPMC RSAT-AD-Tools RSAT-AD-PowerShell RSAT-ADDS-Tools RSAT-ADLDS }.each do |feature|
  windows_feature feature do
    action :install
    not_if {reboot_pending?}
  end
end

windows_reboot 60 do
  reason 'Chef said to'
  only_if {reboot_pending?}
end
