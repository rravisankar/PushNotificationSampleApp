#General
prog_name=$0
startpath=`dirname $0`; export startpath
CONTAINING_FOLDER_LONG="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONTAINING_FOLDER=`basename $CONTAINING_FOLDER_LONG`

command -v cordova >/dev/null 2>&1 || { echo >&2 "Please install cordova.
Refer http://cordova.apache.org/docs/en/3.0.0/guide_cli_index.md.html#The%20Command-line%20Interface"; exit 1; }

########## configurations #########
SUPPORTED_PLATFORMS=(android ios)
PLUGIN_URLS=(https://github.com/cyberflohr/cordova-plugin-jshybugger.git https://github.com/jdhiro/PushPlugin https://git-wip-us.apache.org/repos/asf/cordova-plugin-device.git https://git-wip-us.apache.org/repos/asf/cordova-plugin-console.git)

#Build related settings
DEPLOY_FOLDER=$CONTAINING_FOLDER_LONG/../../Deploy
PROJECT_NAME=$CONTAINING_FOLDER
WWW_LOCATION=$CONTAINING_FOLDER_LONG/www

echo "Deploy Folder: $DEPLOY_FOLDER"
echo "Project Name: $PROJECT_NAME"
echo "WWW SYMLINK: $WWW_LOCATION"


if [ ! -d "$DEPLOY_FOLDER" ]; then
	mkdir $DEPLOY_FOLDER
fi

cd $DEPLOY_FOLDER

if [ ! -d "$PROJECT_NAME" ]; then
	echo "Setting up project"
	cordova create $PROJECT_NAME
	cd $PROJECT_NAME

	if [ ! -L www ]; then
	  if [ -d "$WWW_LOCATION" ]; then
	  	echo "Creating Symlink"
	  	rm -rf www
	  	ln -s $WWW_LOCATION www	
	  fi 
	fi

	for platform in "${SUPPORTED_PLATFORMS[@]}"
	do 
		echo "Adding $platform platform"
		cordova platform add $platform
	done


	for plugin in "${PLUGIN_URLS[@]}"
	do 
		echo "Adding plugin $plugin"
		cordova plugin add $plugin
	done
	
	echo "Done setting up project $PROJECT_NAME"
else
	echo "Project $PROJECT_NAME already exists, skipping creation"
	cd $PROJECT_NAME
fi


echo "Building"

cordova build ios
cordova build android