userAndGroupName="apg_install"

getent group $userAndGroupName > /dev/null
if [ $? -eq 0 ]; then
  echo "$userAndGroupName group exists, deleteing it"
else
  echo "$userAndGroupName group does not exist!"
   echo "Creating group $userAndGroupName"
  /usr/sbin/groupadd -f -r $userAndGroupName 2> /dev/null || :
fi

getent passwd $userAndGroupName > /dev/null
if [ $? -eq 0 ]; then
  echo "$userAndGroupName exists, deleteing it"
else
  echo "$userAndGroupName does not exist!"
  echo "Creating user $userAndGroupName and assign him group $userAndGroupName"
  /usr/sbin/useradd -m -r -c "$userAndGroupName user" $userAndGroupName -g $userAndGroupName 2> /dev/null || :
fi

echo "Adding Sudoers Rights for $userAndGroupName"
echo "Defaults:$userAndGroupName "'!'"requiretty" > /etc/sudoers.d/$userAndGroupName
yumRepoOptions="--disablerepo=* --enablerepo=apg-artifactory*"
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which yum ) clean all $yumRepoOptions" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which yum ) -y install $yumRepoOptions apg-jadas-service-*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which mkdir ) /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) 775 /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) -R 775 /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chgrp ) -R $userAndGroupName /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which unzip ) /etc/opt/it21_ui_* -d /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chmod ) 755 /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which chgrp ) $userAndGroupName /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName
echo "$userAndGroupName ALL= (root) NOPASSWD: $( which mv ) /etc/opt/it21_ui_* /etc/opt/it21_ui_*" >> /etc/sudoers.d/$userAndGroupName