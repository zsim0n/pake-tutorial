<?php

pake_task('global_sender');
function run_global_sender () {
  global $data1;
  $data1 = 'Data from "global_sender"';
}

pake_task('global_receiver','global_sender');
function run_global_receiver () {
  global $data1;
  pake_echo("Received: $data1");
}


pake_task('prop_sender');
function run_prop_sender () {
  $prop = pakeApp::get_instance()->get_properties();
  $prop['data1'] = 'Data from "prop_sender"';
  pakeApp::get_instance()->set_properties($prop);
	
}

pake_task('prop_receiver','prop_sender');
function run_prop_receiver () {
  $prop = pakeApp::get_instance()->get_properties();
  pake_echo("Received: ".$prop['data1']);
}

