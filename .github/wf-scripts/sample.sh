if [ "$message" ]; then
    echo $message
    echo $repo_owner
    gh issue create --title "$message" --body $repo_owner" requests comments on the message..."  
else
    echo "A welcome message was not provided."
fi
