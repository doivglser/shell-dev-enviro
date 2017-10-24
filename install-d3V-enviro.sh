#!/bin/bash
# version 1.00
# first run installs the environment
# run this script like: ../dev-shell-enviro/./iNSTALL.sh
# You can Add Programs to $myPrograms, but remove bevor $HOME/installed

myPrograms="apache2 mysql-server php5 php5-mysql php5-mcrypt sendmail pychecker shellcheck perl dwww git" ;

###     WARNING:    DON'T EDIT ANYTHING BELOW       ###

LANG="C" ;

environinstall="redundanz.sh server-monitor.sh serv-if-up.sh sCRYPtUPdater.sh" ;

		if [ ! $EUID = 0 ] ;
	then
		sudo "$0" ;
else
		if [ ! -e "/home/$SUDO_USER/installed" ] ;
	then

	nNuM=$(echo "$myPrograms" | wc -w) ;
	nNuM2=$(echo "$environinstall" | wc -w) ;

		while [[ "$nNuM" != "0" ]] ;
	do
		toInst=$(awk '{print $'"$nNuM"'}'<<<"$myPrograms") ;

		wH3RE=$(whereis "$toInst" | cut -f2 -d: | cut -f2 -d\ ) ;
# INSTALL
		if [[ "${#wH3RE}" != "0" ]] ;
	then
		apPR="$toInst, allready installed" ;
		((nNuM--)) ;
	else
		echo -e "\ninstalling ${toInst}..." ;
		nohup apt-get -f -m -y install "$toInst" | tee -a "/home/$SUDO_USER/installed" &
		wait ;
		sleep 1 ;
		apPR="$toInst, INSTALLED! " ;
		sleep 0.5 ;
		((nNuM--)) ;
fi
		if [ "$nNuM" = "0" ]
	then
		clear ;
		echo -e "\n done." ;
fi
# ON THE SCREEN
		printf "\rtesting for apps, $nNuM remaining, $apPR" ; sleep 0.5 ;
		clear ;
done
	ip link show | grep ether | awk '{print $2}' | tee -a "/home/$SUDO_USER/vendorsmac" ;
	chown "$SUDO_USER":"$SUDO_USER" "/home/$SUDO_USER/vendorsmac" ;
	chown "$SUDO_USER":"$SUDO_USER" "/home/$SUDO_USER/installed" ;

		if [[ $PWD =~ 'bash-dev-enviro' ]] && [[ ! $environinstall =~ $(ls /usr/local/bin/*) ]] || [[ $(ls /usr/local/bin/*) =~ '' ]] ;
	then
		while [[ "$nNuM2" != "0" ]] ;
	do
		clear ;
		toCopyPath=$(awk '{print $'"$nNuM2"'}'<<<"$environinstall") ;
		echo -e "\n" ;
		sudo cp -f "/home/$SUDO_USER/bash-dev-enviro/$toCopyPath" "/usr/local/bin/$toCopyPath" ;
		sudo chown root:root "/usr/local/bin/$toCopyPath" ;
		sudo chmod 4755 "/usr/local/bin/$toCopyPath" ;
		sudo chmod u+s "/usr/local/bin/$toCopyPath" ;
		printf "\r$toCopyPath" ; sleep 0.5 ;
		((nNuM2--)) ;
done

	echo -e "\nwe have bash-dev-enviro successfully installed" ;

	else
		echo -e "\nallready installed, remove /home/$SUDO_USER/installed \nif you want to add new Programs to myPrograms" ;
fi
fi
fi
