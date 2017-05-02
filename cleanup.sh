echo "Stopping Containers..."
docker stop $(docker ps -a -q --filter="name=mysql-")
echo "Removing Containers..."
docker rm $(docker ps -a -q --filter="name=mysql-")
echo "Cleaning Directory Master"
rm -rf master/backup/*
rm -rf master/data/*
rm -rf master/log/*
echo "Cleaning Directory Slave"
rm -rf slave/backup/*
rm -rf slave/data/*
rm -rf slave/log/*
echo "Done"
