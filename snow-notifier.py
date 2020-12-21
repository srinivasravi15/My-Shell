import sys
from slacker import Slacker
slack = Slacker('Slack bot token')
#message="```Health Status Alert! The following number of streams are down in respective regions```"
#slack.chat.post_message('#slack_channel_name', message);
file="Parkinglotstatus.txt"
slack.files.upload(file, channels='#slack_channel_name');