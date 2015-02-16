#!/bin/bash

#Default Values
CQ_USER="admin"
CQ_PASSWD="admin"
PKG="content"
VERSION="1.0"
DOMAIN="http://localhost:4502"
GRP_NAME="my_packages"
FILTER_PATH=`pwd`
PKG_NAME="$PKG-$VERSION"
SCPT_PATH=`pwd`

function show_help()
{
	echo -e "Usage"
        echo -e "\t\t-u: Username"
        echo -e "\t\t-p: Password"
        echo -e "\t\t-z: Package Name"
        echo -e "\t\t-v: Package Version"
        echo -e "\t\t-d: Domain/IP with port"
        echo -e "\t\t-g: Group Name"
        echo -e "\t\t-f: fliter.xml path"
}

while getopts "h?:u:p:z:v:d:g:f:" opt; do
    case "$opt" in
    h)
        show_help
        exit 0
        ;;
    u)  CQ_USER=$OPTARG
        ;;
    p)  CQ_PASSWD=$OPTARG
        ;;
    z)  PKG=$OPTARG
        ;;
    v)  VERSION=$OPTARG
        ;;
    d)  DOMAIN=$OPTARG
        ;;
    g)  GRP_NAME=$OPTARG
        ;;
    f)  FILTER_PATH=$OPTARG
        ;;
    esac
done

function build_pkg() {

# Build the content package
curl -u $CQ_USER:$CQ_PASSWD -X POST $DOMAIN/crx/packmgr/service/.json/etc/packages/$GRP_NAME/$PKG_NAME.zip?cmd=build
sleep 2

# Download the content package
curl -C - -O -u $CQ_USER:$CQ_PASSWD $DOMAIN/etc/packages/$GRP_NAME/$PKG_NAME.zip
sleep 2
}

function create_pkg() 
{
# Create the package
curl -u $CQ_USER:$CQ_PASSWD -X POST $DOMAIN/crx/packmgr/service/.json/etc/packages/$PKG.zip?cmd=create -d packageName=$PKG_NAME.zip -d groupName=$GRP_NAME
sleep 2

build_pkg

# unpack the downloaded the package in tmp folder
mkdir -p $SCPT_PATH/tmp
mv $SCPT_PATH/$PKG_NAME.zip $SCPT_PATH/tmp
cd $SCPT_PATH/tmp
unzip $PKG_NAME.zip
rm -rf $SCPT_PATH/tmp/META-INF/vault/filter.xml
cp -pr $SCPT_PATH/filter.xml $SCPT_PATH/tmp/META-INF/vault/
rm -rf $SCPT_PATH/tmp/$PKG_NAME.zip
zip -r $PKG_NAME.zip META-INF jcr_root

#upload the package to server
curl -u $CQ_USER:$CQ_PASSWD -F file=@$PKG_NAME.zip -F name=$PKG_NAME -F force=true $DOMAIN/crx/packmgr/service.jsp
sleep 2

# Delete the tmp folder
cd -
rm -rf $SCPT_PATH/tmp

build_pkg

}

curl -u $CQ_USER:$CQ_PASSWD -X POST $DOMAIN/crx/packmgr/service.jsp?cmd=ls | grep "<name>" | grep "$PKG-$VERSION"

if [ echo $? -eq 1 ]
then
        echo "No package available"
        create_pkg
else
        echo "Package already available"
        build_pkg
fi
