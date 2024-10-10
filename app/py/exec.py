def execute_command():
    user_input = input("Enter your command: ")
    eval(user_input)  # This is a security risk

if __name__ == "__main__":
    execute_command()