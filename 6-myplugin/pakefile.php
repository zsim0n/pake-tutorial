<?php

pakeApp::get_instance()->add_plugin_dir(dirname(__FILE__).'/tasks');
pake_import('MyPlugin');

pake_task('default','pakeMyPluginTask::foo');  // <-- Invoking plugin task here!
function run_default() {
  pake_echo("I am the default task");
}
