
# pip install mysql-connector-python
import mysql.connector

def connect_to_database(username, password):
    # Connect to the MySQL database
    connection = mysql.connector.connect(
        host="localhost",
        user=username,
        password=password,
        database="example_db"  # Replace with your database name
    )
    cursor = connection.cursor()
    
    # Vulnerable SQL query for demonstration purposes
    user_input = "admin' OR '1'='1"  # This is an example of SQL injection
    query = f"SELECT * FROM users WHERE username = '{user_input}'"
    cursor.execute(query)
    
    # Fetch and print the results
    results = cursor.fetchall()
    for row in results:
        print(row)
    
    # Close the connection
    connection.close()

if __name__ == "__main__":
    username = "admin"  # Hardcoded credentials
    password = "password123"  # Hardcoded credentials
    print(f"Connecting to the database with username={username} and password={password}")
    connect_to_database(username, password)
