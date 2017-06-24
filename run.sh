LOCALDIR=$(pwd)
docker run -it -v $LOCALDIR/data/:/bitradio/ -d --name br-wallet -t bitradio
