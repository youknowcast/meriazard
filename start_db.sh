## start mongoDB 
WORKSPACE=/Users/youknow/workspace/meriazard
cd $WORKSPACE
mongod -nojournal -noprealloc --fork --logpath ./mongo.log -dbpath mongodb/
