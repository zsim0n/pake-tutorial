<?php

pake_desc('Default task at show "Hello World" message');
pake_help('This is a help for this task');
pake_task('default');

function run_default() {
  pake_echo('Hello World I am a Pake Task');
}
