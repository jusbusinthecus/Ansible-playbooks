#For the third client

#version=RHEL9
install
lang en_US.UTF-8
keyboard us
network --bootproto=dhcperver= --hostname=ansible-client2
rootpw --iscrypted $6$randomSalt$hashedPasswordHere # to create a hashed password run this on a rhel command "openssl passwd -6 your_password_here" and add to this line.
timezone America/New_York --isUtc
user --name=ansible_user3 --password=your_hashed_password_here --gecos="Ansible User" --groups=wheel

# Partitioning
autopart --type=lvm

# System services
services --enabled="sshd"

# Package selection
%packages
@^server-with-gui
@^development
@^server
git
%end

# Post-installation script
%post
# Install additional Python packages if needed
pip3 install --upgrade pip
pip3 install boto boto3  # Optional: for AWS integrations
echo "Ansible installation complete."
%end


####################################################################

Once you finish with the file ensure httpd is installed and enabled --now, then copy the kick start file to /var/www/html, change permissions to
make it readable, verify you can reach the page from another computer.
- dnf install http -y
- systemctl enable --now httpd
- cp <kickstart_file> /var/www/html
- curl http://<path_to_file> # may not be necessary
- chmod a+r <path_to_file>


#################### If this is a success make sure you add it to the automations folder as something useable###################################
