userAndGroupName="apg_install"

getent group $userAndGroupName > /dev/null
if [ $? -eq 0 ]; then
  echo "$userAndGroupName group already exists"
else
  echo "$userAndGroupName group does not exist!"
   echo "Creating group $userAndGroupName"
  /usr/sbin/groupadd -f -r $userAndGroupName 2> /dev/null || :
fi

getent passwd $userAndGroupName > /dev/null
if [ $? -eq 0 ]; then
  echo "$userAndGroupName user aleady exists"
else
  echo "$userAndGroupName does not exist!"
  echo "Creating user $userAndGroupName and assign him group $userAndGroupName"
  /usr/sbin/useradd -m -r -c "$userAndGroupName user" $userAndGroupName -g $userAndGroupName 2> /dev/null || :
fi

downloadDir="/home/apg_install/downloads"
if [-d "$downloadDir"]; then
  echo "$downloadDir already exists"
else
  echo "Creating $downloadDir"
  mkdir $downloadDir
  echo "Changing group for $downloadDir"
  chgrp users $downloadDir
  echo "Changing owner for $downloadDir"
  chown apg_install $downloadDir
fi

echo "Adding Sudoers Rights for $userAndGroupName"
echo "Defaults:$userAndGroupName "'!'"requiretty" > /etc/sudoers.d/$userAndGroupName
yumRepoOptions="--disablerepo=* --enablerepo=apg-artifactory*"
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which yum ) clean all $yumRepoOptions" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which yum ) -y install $yumRepoOptions apg-jadas-service-*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which mkdir ) /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which mkdir ) -p /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) 775 /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) -R 775 /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chgrp ) -R $userAndGroupName /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which unzip ) /opt/it21_ui* -d /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) 755 /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chgrp ) $userAndGroupName /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which mv ) /opt/it21_ui* /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chown ) -R apg_install /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) 777 /opt/it21_ui*" >> /etc/sudoers.d/$userAndGroupName

echo "Adding Sudoers Rights for Digiflex Installations"
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which rpm ) -Uvh downloads/apg-digiflex-jadas-*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which rpm ) -Uvh downloads/apg-digiflex-web-it21*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which rpm ) -Uvh downloads/apg-digiflex-web-sa*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which unzip ) downloads/digiflex-it21-ui* -d /opt/digiflex_ui*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) -R 755 /opt/digiflex_ui*" >> /etc/sudoers.d/$userAndGroupName

echo "Adding Sudoers Rights for GUI(s) Installations, it might become more restrictive"
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which unzip) *.zip" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which unzip) *.zip -d*" >> /etc/sudoers.d/$userAndGroupName