WORKSPACE=/Users/youknow/workspace/meriazard
SERVER_PORT=3000

pushd $WORKSPACE

# if already server started. lets restart.
wget --output-document=/dev/null -q --spider localhost:${SERVER_PORT}
is_active=`echo $?`
if [ "${is_active}" = "0" ]; then
  pgrep -f "node .* app.js" | xargs kill
fi

## coffee compile
coffee -cb . 

# start node.
nohup node --debug app.js > result.log &

popd
