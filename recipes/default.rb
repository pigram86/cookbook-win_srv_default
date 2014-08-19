#
# Cookbook Name:: win_srv_default
# Recipe:: default
#
# Copyright (C) 2013-2014 Todd Pigram
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
case node['platform_version']
when "6.3.9600"
  include_recipe "win_srv_default::w2012r2"
when "6.2.9200"
  include_recipe "win_srv_default::w2012"
when "6.1.7601"
  include_recipe "win_srv_default::w2k8r2"
end

  
  
  