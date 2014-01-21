<?php

pake_desc('Description for "bar" task');
pake_task('bar');

function run_bar() {
  pake_echo('I am the "Bar" task.');
}

pake_desc('Description for "Foo" task');
pake_task('foo', 'bar'); 		// <-- The dependency is here!

function run_foo() {
  pake_echo('I am the "Foo" task.');
}


