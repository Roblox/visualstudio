
#
# Author:: Shawn Neal <sneal@sneal.net>
# Cookbook Name:: visualstudio
# Recipe:: install
#
# Copyright 2013, Daptiv Solutions, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Visualstudio::Helper)

# Install each specified edition/version
installs.each do |install|
  version = install['version']
  edition = install['edition']
  url = source_download_url(version, edition)
  # allow to override the install dir on a per-edition basis
  install_directory = node['visualstudio'][version][edition]['install_dir'] || node['visualstudio'][version]['install_dir'] # rubocop:disable Metrics/LineLength
  combined_success_codes = installer_success_codes(version)

  visualstudio_edition "visualstudio_#{version}_#{edition}" do
    edition     edition
    version     version
    install_dir install_directory
    source      url
    success_codes combined_success_codes if version == '2017'
    product_key   node['visualstudio'][version][edition]['product_key']
    package_name  node['visualstudio'][version][edition]['package_name']
    checksum      node['visualstudio'][version][edition]['checksum']
    preserve_extracted_files  node['visualstudio']['preserve_extracted_files']
    installer_file            node['visualstudio'][version][edition]['installer_file']
    configure_basename        node['visualstudio'][version][edition]['config_file'] if version == '2010'
  end
end
