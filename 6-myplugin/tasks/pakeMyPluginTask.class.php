<?php

class pakeMyPluginTask {

  public static function import_default_tasks() {
    pake_task('pakeMyPluginTask::foo'); 
  }
  private static function internal_feature() {
    pake_echo_action("internal_feature","I am the internal feature");
  }
  /**
    * Foo Task Description
    *
    * Foo Task Help
  */
  public static function run_foo(pakeTask $task, $args, $options) {
    self::internal_feature();
    pake_echo("I am the pakeMyPlugin::foo task");
  }
}
