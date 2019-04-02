name 'base_test'

default_source :supermarket

cookbook 'visualstudio', path: '../../'

run_list.push(
  'visualstudio::default'
)

#
# Attributes
#
# Uncomment the overrides to test specific parts of functionality. 
# WIP to turn into a proper test suite
#
# override['visualstudio']['2017']['additional_success_codes'] = [1]
# override['visualstudio']['installs'] = [
#   {
#     'version' => '2017',
#     'edition' => 'community',
#   },
# ]
