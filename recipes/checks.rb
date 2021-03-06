#
# Cookbook Name:: uchiwa-sensu
# Recipe:: client
#
# Copyright (C) 2014 Simon Plourde
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

plugins = '/etc/sensu/plugins'

# Success
sensu_check 'check_success' do
  command "#{plugins}/uchiwa/return.rb -c 0"
  handlers ['default']
  subscribers ['linux']
end

# Warning
sensu_check 'check_warning' do
  command "#{plugins}/uchiwa/return.rb -c 1"
  handlers ['default']
  subscribers ['linux']
end

# Critical
sensu_check 'check_critical' do
  command "#{plugins}/uchiwa/return.rb -c 2"
  handlers ['default']
  subscribers ['linux']
end

# Aggregate
sensu_check 'check_dummy' do
  command "#{plugins}/uchiwa/return.rb -c 0"
  subscribers ['linux']
  aggregate true
end

sensu_check 'check_aggregate' do
  command "#{plugins}/sensu/check-aggregate.rb -c check_dummy -W 50 -C 75"
  handlers ['default']
  subscribers ['linux']
end
