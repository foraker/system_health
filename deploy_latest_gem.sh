#!/bin/bash
cd "${0%/*}"
rm -f *.gem && bundle exec rspec && gem build system_health.gemspec && gem push *.gem
