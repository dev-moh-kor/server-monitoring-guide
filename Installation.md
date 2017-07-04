Install Linux Agent
Downloading, Installing and Running Smart Agent for Linux

The Smart Agent for Linux allows monitoring of processes, CPU, memory and hard drive utilization on a Linux server.
System requirements
OS Linux x32
OS Linux x64

Shared library dependencies
libssl.so.0.9.7 (or higher) libssl must be installed
libc.so.6
libxml2.so or libxml2.so.2

    Note: In case your ssl library is located in another directory than /usr/lib or has a different name, you should create a symbolic link, e.g.

ln -s /lib/libssl.so.0.9.7 /usr/lib/libssl.so.0.9.7

The Smart Agent should be run as a root user and should be allowed to establish an outgoing HTTPS (443) connection for receiving response data.

The Smart Agent files and directories have the following structure:

       smagent/
       smagent/bin/
       smagent/bin/ smagent
       smagent/bin/updater
       smagent/doc/README
       smagent/doc/LICENSE
       smagent/logs/smagent.log
       smagent/logs/smagent.pid
       smagent/smagent.sh


While adding a Server/Device monitor for the first time in your Monitis dashboard, if you haven’t yet downloaded the Smart Agent, the Add Server/Device Monitor window will open.

![1](https://cloud.githubusercontent.com/assets/23449715/24948919/31b49f92-1f6c-11e7-924c-b39b79e036e1.png)

Alternatively, you can go to the Tools menu and select Download Agent.

![2](https://cloud.githubusercontent.com/assets/23449715/24948949/4808654e-1f6c-11e7-9195-3cec29e87e41.png)

Click on Download for Linux to download the Smart Agent for Linux operating system (the supported Linux versions are shown).

Download of .zip file will be started.

Wait for download to be completed and follow the steps below to install the Smart Agent.

1. Place the file onto your Linux server. Once the agent is on the server, extract the .tar file.

Example:

    sudo tar -xvwzf smagentLinuxAgent-32bit.tar.gz

2. Navigate to the extracted smagent directory and run the following command:

       sudo ./smagent.sh

You will then be presented with a list of possible commands to use.

![3](https://cloud.githubusercontent.com/assets/23449715/24949020/8291ecb2-1f6c-11e7-9744-1be7e1801843.png)

3. To begin the install you will need to use the “conf” command.

       sudo ./smagent.sh conf

You will be presented with the Configuration Wizard.

![4](https://cloud.githubusercontent.com/assets/23449715/24949125/d1ee9558-1f6c-11e7-9b07-3b3f61090ffc.png)

4. Enter a new path to the Smart Agent directory, or press Enter to use the current location.

5. Enter the agent key associated with your Monitis account. Please note that the agent key is case-sensitive. Then press Enter.

![5](https://cloud.githubusercontent.com/assets/23449715/24949123/d1d6c7d4-1f6c-11e7-9619-4dc7f404f7e2.png)

6. Enter the name of the agent as you would like it to appear in your Monitis dashboard.

![6](https://cloud.githubusercontent.com/assets/23449715/24949120/d1d52622-1f6c-11e7-854b-bda1f01ff1f6.png)

7. The Smart Agent uses plug-ins for configuring some of the monitors. You can enter a new path for the Smart Agent plug-ins directory, or press Enter to use the shown location.

![7](https://cloud.githubusercontent.com/assets/23449715/24949121/d1d551c4-1f6c-11e7-84a6-f70168dd49f3.png)

8. When completed, you will be presented with the following to ensure the configuration was successful.

![8](https://cloud.githubusercontent.com/assets/23449715/24949122/d1d58428-1f6c-11e7-9e68-de4e7ec72a44.png)

9. Enter the following command to start the Agent: 
 
       sudo ./smagent.sh start

You will see the following screen:

![9](https://cloud.githubusercontent.com/assets/23449715/24949124/d1d8861e-1f6c-11e7-9264-48b1ece6fcdb.png)

Additionally the wizard creates a “logs” directory in Smart Agent’s home folder for smagent.log and smagent.pid files.11.

Now you can return to your Monitis dashboard to configure the monitors you would like for this agent (see Adding Server/Device Monitors).

NOTE: The Linux Smart Agent will NOT automatically start after a reboot. Please complete the below steps to ensure the agent starts at boot time.
Using init.d scripts

Here are the steps that can be completed to automatically start Linux internal agent at bootup using init.d scripts.

Browse to this directory: cd /etc/init.d
Create using the vi editor a shell script that will start the Smart Agent:
Type the following: 
       sudo vi <hit Enter>

Hit the Insert key.

Copy the following text and paste it in your vi editor (change the <path to the smagent on your server> to be the installed smagent directory): 

       #!/bin/sh -e
       # chkconfig: 345 56 24
       # description: smagent
       # processname: smagent
       ### BEGIN INIT INFO
       # Provides: smagent
       # Required-Start:
       # Required-Stop: $local_fs
       # Should-Start:
       # Should-Stop:
       # Default-Start:
       # Default-Stop: 0 6
       # Short-Description: Control internal agent.
       ### END INIT INFO

 /<path to the smagent directory on your server>/smagent.sh start

Hit the Escape key to stop editing the file.

:wq smagentstartup <hit Enter to save and return to the terminal. This will write (w) the script code and then quit (q) the vi tool giving the script file name of  “smagentstartup”>

sudo chmod 755 smagentstartup<hit Enter to ensure execute permissions for the script>
For enabling auto run of Smart Agent type either of the below commands:
– update-rc.d smagentstartup defaults<hit Enter to add the script to your server’s start up list>
– chkconfig smagentstartup on <hit Enter to add the script to your server’s start up list>

Using systemd

Here are the steps that can be completed to automatically start Linux internal agent at bootup for latest versions of CentOS, RHEL and other Linux systems using systemd.

Browse to this directory: cd /usr/lib/systemd/system/
Create using the vi editor a system unit file that will start the Smart Agent. Type the following:

       sudo vi 
<hit Enter>
Hit the Insert key.
Copy the following text and paste it in your vi editor (change the <path to the smagent directory on your server> to be the installed smagent directory):

        [Unit]
        Description=Control internal agent.
        After=syslog.target network.target
        [Service]
        Type=forking
        ExecStart=/< path to the smagent directory on your server >/smagent.sh start
        [Install]
        WantedBy=multi-user.target
        
Hit the Escape key to stop editing the file.
       :wq smagentstartup.service 
<hit Enter to save the script and return to the terminal. This will write (w) the script code and then quit (q) the vi tool giving the script file name of “smagentstartup.service”>

For enabling auto run of SmartAgent type:
       systemctl enable smagentstartup.service 
<hit Enter to add the service to your server’s service list>
 

Adding HTTP Proxy Support

The Smart Agent communicates with Monitis backend via HTTPS protocol.

Enabling HTTP proxy support for the Smart Agent gives you the possibility to install the Smart Agent behind the firewall, and to exchange data between Smart Agent and Monitis backend via proxy server.

To use proxy server, you should add a “HTTPPROXY” parameter in the smagent.conf file.
The format of the value is some.proxy.com:port, or alternatively you can provide IP instead of URL.

Example:
HTTPPROXY 86.51.26.14:5555

Running and Stopping the Agent

Use “smagent.sh status” command to show the current status of the Smart Agent.

Use “smagent.sh start”/”smagent.sh stop” command to run or stop the Smart Agent.

![10](https://cloud.githubusercontent.com/assets/23449715/24949119/d1d25d16-1f6c-11e7-8787-f4a912de0668.png)

Removing the Smart Agent

To remove the Smart Agent, simply delete smagent directory from your Linux machine.
