import sys
from slacker import Slacker
slack = Slacker('Slack bot token')
file="file1.txt"
slack.files.upload(file, channels='#slack_channel_name');
file="file2.txt"
slack.files.upload(file, channels='#slack_channel_name');
file="file3.txt"
slack.files.upload(file, channels='#slack_channel_name');
file="file4.txt"
slack.files.upload(file, channels='#slack_channel_name');