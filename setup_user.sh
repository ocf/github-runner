#!/bin/sh
set -e

groupadd ocfroot
groupadd opstaff
groupadd ocfstaff

useradd gstaff
usermod -aG ocfstaff gstaff

useradd testopstaff
usermod -aG opstaff testopstaff

usermod -aG ocfroot root

useradd staff1
usermod -aG ocfstaff staff1
useradd staff2
usermod -aG ocfstaff staff2
useradd staff3
usermod -aG ocfstaff staff3
useradd staff4
usermod -aG ocfstaff staff4

useradd guser
useradd sshd
