import psycopg2, os

conn = psycopg2.connect(
        host="innovationai_postgres",
        database="app",
        user = os.environ['DB_USERNAME'],
        password= os.environ['DB_PASSWORD']
)
cur = conn.cursor()
cur.execute('''CREATE TABLE IF NOT EXISTS users (
                ID SERIAL PRIMARY KEY,
                name VARCHAR(255)
                );
            '''
        )
conn.commit()
cur.execute("INSERT INTO users (name) VALUES ('testuser');")
conn.commit()
cur.close()
conn.close()