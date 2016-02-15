#!/usr/bin/env bash
# https://github.com/ManageIQ/manageiq/pull/5230/files

export PARALLEL_TEST_PROCESSORS=8
export PARALLEL='^spec/(controllers|helpers|initializers|javascripts|lib|mailers|models|presenters|requests|routing|services|task_helpers|tools|views)'
bundle exec parallel_test -e "bundle exec rake test:vmdb:setup"
bundle exec rake parallel:spec
