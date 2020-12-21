from jira import JIRA
options = {'server': 'JIRA Dashboard URL'}
jira = JIRA(options, basic_auth=('encrypted username', 'encrypted passwd'))
size = 100
initial = 0
while True:
    start= initial*size
    issues = jira.search_issues('project=<PROJECT_NAME>',  start,size)
    if len(issues) == 0:
        break
    initial += 1
    for issue in issues:
        print ('ticket-no=',issue)
        print ('IssueType=',issue.fields.issuetype.name)
        print ('Status=',issue.fields.status.name)
        print ('Summary=',issue.fields.summary)