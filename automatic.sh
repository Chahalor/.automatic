# Big Header

auto_setup()
{
	echo "setup function"
}

disable()
{
	echo "disable function"
}

settings()
{
	echo "setting function"
}

main()
{
	echo "Welcomme to .automatic"
	echo "What can we do to you ?"
	echo "1. setup an automatism"
	echo "2. disable an automatism"
	echo "3. setting"
	echo "q. quit"

	while true;
	do
		read -p ".automatic > " ACTION
		case $ACTION in
			1)
				auto_setup
				;;
			2)
				disable
				;;
			3)
				settings
				;;
			q|quit)
				echo "Quitting..."
				break
				;;
			*)
				echo "Invalid option"
				;;
		esac
	done
}


main