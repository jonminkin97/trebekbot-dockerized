#!/bin/bash
cd /root/trebekbot
redis-server &
bundle exec ruby app.rb -o 0.0.0.0 -p 80