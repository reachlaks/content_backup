Name:-         content_backup (Shell version)
Authors:-      Lakshmanan PL (reachlaks@hotmail.com)
Date:-         February 13, 2015

(1) INTRODUCTION
-----------------
Content Backup is an open-source script for taking the content/dam backup which can include even any of the custom defined filters.\

This is a shell script which processes input parameters to generate the content backup as zip file which can download and stored outside of CQ\

This script will run on any Linux platform

(2) HISTORY
-----------
This is the initial version of the content_backup script.

(3) REQUIRED SYSTEMS
--------------------
-Shell (bash)

(4) PACKAGE FILES
------------------
The following files are included in the mathsPIC package.

content_backup.sh	  % The main script to create content backup
filter.xml		  % Sample filter.xml has been attached to be modified according to your needs
README.txt		  % This file

(5) INSTALLATION (Unix/Linux)
-----------------------------

a) Download this zip package to your system
b) Copy to the folder where you like to run this script from
c) Unzip the downloaded source file
d) Make the chown permissions to the base folder of the script location for the required user
e) Make the content_backup.sh script executable for the user
f) Edit the filter.xml based on your needed
g) Now we are good to run the script with parameters (look for usage section for parameters)


(6) USAGE  (see manual for full details)
----------------------------------------
In Unix/Linux one way of running content_backup is to type the following at the command-line (options are shown in square brackets)

Syntax:
   sh content_backup.sh [-u] [-p] [-z] [-v] [-d] [-g] [-f]
   
Options:
 -u		CQ username who has permission in those folders (e.g -u admin)
 -p		CQ Password for respective username (e.g -p admin)
 -z		Name of the package to be created in package manager (e.g -z content)
 -v		Version of the package (e.g -v 1.0)
 -d		Domain/IP with port of the CQ instance (e.g -d http://localhost:4502/)
 -g		Group name of the package classification (e.g -g my_packages)
 -f		Location of the filter.xml (e.g -f /opt/scripts/filter.xml)

However, even if we don't mention any of the above parameters it will pick a default value for all of the parameters and run the script.

(7) LICENSE (LPPL):
-------------
 This file is part of content_backup.zip.

    content_backup.zip is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    content_backup.zip is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with content_backup.zip.  If not, see <http://www.gnu.org/licenses/>.
-----------------
End of README.txt
-----------------

=========================
