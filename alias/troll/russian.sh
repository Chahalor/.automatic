# Big Header

RUN=true
while [ $RUN = true ]; do
	PID=$RANDOM

	kill -0 $PID 2>/dev/null
	if [ $? -ne 1 ]; then
		RUN=false
	fi
done

echo "killed process $PID"