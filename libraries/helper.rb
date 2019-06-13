module Visualstudio
  # VS cookbook library helper methods
  module Helper
    # Checks if the specified Windows installer package is installed
    def package_is_installed?(package_name)
      if RUBY_PLATFORM =~ /mswin|mingw32|windows/
        windows_package_is_installed?(package_name)
      else
        false
      end
    end

    # Array of VS edition/version hashes to install
    def installs
      return node['visualstudio']['installs'] unless node['visualstudio']['installs'].nil?
      [{
        'edition' => node['visualstudio']['edition'],
        'version' => node['visualstudio']['version'],
      }]
    end

    # Array of unique VS versions exclusive of editions
    def versions
      installs.map { |i| i['version'] }.uniq
    end

    # Gets the version/edition ISO download URL or raises an error
    def source_download_url(version, edition)
      src = iso_source(version, edition)
      assert_src_is_not_nil(src, version, edition) unless node['visualstudio'][version][edition]['installer_file'].empty?
      url = nil
      url = ::File.join(src, node['visualstudio'][version][edition]['filename']) unless src.empty?
      url
    end

    def installer_success_codes(version)
      if node['visualstudio'][version].key? 'additional_success_codes'
        VisualStudio::VS_2017_SUCCESS_CODES + node['visualstudio'][version]['additional_success_codes']
      else
        VisualStudio::VS_2017_SUCCESS_CODES
      end
    end

    private

    # Gets the version/edition ISO download root URL
    def iso_source(version, edition)
      src = node['visualstudio'][version][edition]['default_source']
      src = node['visualstudio']['source'] if node['visualstudio']['source']
      src = node['visualstudio'][version][edition]['source'] if node['visualstudio'][version][edition]['source']
      src
    end

    # Fails the Chef run if the visualstudio download source is not set
    def assert_src_is_not_nil(src, version, edition)
      if src.nil?
        raise 'The ISO download source is empty! '\
          "Set the node['visualstudio']['#{version}']['#{edition}']['source'] " \
          'or node[\'visualstudio\'][\'source\'] attribute and run again!'
      end
    end

    def windows_package_is_installed?(package_name)
      require 'win32/registry'
      Win32::Registry::HKEY_LOCAL_MACHINE.open(uninstall_reg_key) do |uninstall_reg|
        uninstall_reg.each_key do |subkey, _wtime|
          software_reg_key = "#{uninstall_reg_key}\\#{subkey}"
          Win32::Registry::HKEY_LOCAL_MACHINE.open(software_reg_key) do |software_reg|
            return true if package_display_name(software_reg) == package_name
          end
        end
      end
      false
    end

    # Inspired by https://github.com/btc-ag/chef-vs2017/blob/develop/libraries/vs2017.rb
    def vs2017_vswhere(edition, property)
      vswhere_exe = '"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe"'

      # make first character uppercase
      product = edition.sub(/\S/, &:upcase)
      cmd = Chef::Mixlib::ShellOut.new(
        "#{vswhere_exe} -all -version [15.0,16.0) -property #{property} -products Microsoft.VisualStudio.Product.#{product}",
        returns: [0, 1]
      )
      cmd.run_command
      cmd.error!
      cmd
    end

    def vs2017_edition_installed?(edition)
      cmd = vs2017_vswhere(edition, 'installationVersion')
      cmd.stderr.empty? && (cmd.stdout =~ /^15./)
    end

    def uninstall_reg_key
      if node['kernel']['machine'] == 'x86_64'
        'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
      else
        'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
      end
    end

    def package_display_name(software_reg)
      software_reg['DisplayName']
    rescue
      ''
    end
  end
end
