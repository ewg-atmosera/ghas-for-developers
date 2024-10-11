<<<<<<< HEAD
if [ "$message" ]; then
    echo $message
    echo $repo_owner
    gh issue create --title "$message" --body $repo_owner" requests comments on the message..."  
else
    echo "A welcome message was not provided."
fi
=======
set -x
if [ "$message" ]; then
    echo $message
    echo $repo_owner
    gh issue create --title "$message" --body $repo_owner" requests comments on the message..."  
else
    echo "A welcome message was not provided."
fi

>>>>>>> 4677756daa20bb6bfe11c663ae9ed08b7946bd2e
