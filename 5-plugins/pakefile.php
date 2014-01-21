<?php

pake_task('yaml');
function run_yaml() {
  $yaml = pakeYaml::loadFile('example.yml'); 
  pake_echo($yaml['app']);
}

pake_task('finder');
function run_finder () {
  pake_replace_tokens(
    pakeFinder::type('file')->name('example.yml'),
    '.',
    '###',
    '###',
    array('type'=>'type1')
  );
}
