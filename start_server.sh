WORKSPACE=/Users/youknow/workspace/meriazard

cd $WORKSPACE
## coffee compile
coffee -cb . 

# start node.
nohup node --debug app.js > result.log &
