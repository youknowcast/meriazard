WORKSPACE=/Users/youknow/workspace/meriazard
SERVER_PORT=3000
USE_DEBUGGER=1
# the port where node-inspector worked.
DEBUGGER_PORT=8080

pushd $WORKSPACE
# if already server started. lets restart.
echo "start server.."
wget --output-document=/dev/null -q --spider localhost:${SERVER_PORT}
is_active=`echo $?`
if [ "${is_active}" = "0" ]; then
  pgrep -f "node .* app.js" | xargs kill
fi

# kill debugger if node-inspector is worked.
wget --output-document=/dev/null -q --spider localhost:${DEBUGGER_PORT}
is_debugger_active=`echo $?`
if [ "${is_debugger_active}" = "0" ]; then
  pgrep -f "node-inspector" | xargs kill
fi

## coffee compile
echo "compile coffee.."
coffee -cb . 

# start node.
echo "starting node.."
opt=""
if [ "${USE_DEBUGGER}" = "1" ]; then
  opt="${opt} --debug "
fi
nohup node ${opt} app.js > result.log &

if [ "${USE_DEBUGGER}" = "1" ]; then
  echo "debug mode is on. node-inspector is starting."
  echo "check below inspector log."
  node-inspector
fi

popd
