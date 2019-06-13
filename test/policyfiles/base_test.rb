name 'base_test'

default_source :supermarket

cookbook 'visualstudio', path: '../../'

run_list.push(
  'visualstudio::default'
)

#
# Attributes for VS 2017
#

# default['visualstudio']['preserve_extracted_files'] = true
#
# override['visualstudio']['2017']['additional_success_codes'] = [1]
# override['visualstudio']['installs'] = [
#   {
#     'version' => '2017',
#     'edition' => 'community',
#   },
# ]
