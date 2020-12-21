import sys
from slacker import Slacker
slack = Slacker('Slack bot token')
file="degraded_stream_alert.txt"
slack.files.upload(file, channels='#slack_channel_name');