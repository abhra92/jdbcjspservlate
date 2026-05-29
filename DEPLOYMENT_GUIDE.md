# Deployment Guide (Step by Step)

This guide walks you through hosting this JSP/Servlet + MySQL app on the internet using Tomcat 10.1+ and a remote MySQL database.

## Checklist

- [ ] Prepare a remote MySQL database
- [ ] Update DB credentials to use environment variables
- [ ] Build the WAR with Maven
- [ ] Install Tomcat 10.1+ on a server
- [ ] Deploy the WAR to Tomcat
- [ ] Configure HTTPS (recommended)
- [ ] Verify the app in a browser

## 1) Prepare a Remote MySQL Database

You can use a managed MySQL provider (AWS RDS, DigitalOcean, Render, Railway, PlanetScale, etc.) or your own VPS MySQL instance.

- Create a database named `studentdb`.
- Create a dedicated user (do not use `root`).
- Allow network access from your server’s IP.

Example SQL (run in your provider’s SQL console):

```sql
CREATE DATABASE studentdb;
CREATE USER 'studentapp'@'%' IDENTIFIED BY 'STRONG_PASSWORD_HERE';
GRANT ALL PRIVILEGES ON studentdb.* TO 'studentapp'@'%';
FLUSH PRIVILEGES;
```

Then run your schema from `database-setup.sql` against the remote DB.

## 2) Update DB Connection to Use Environment Variables

Edit `src/main/java/com/example/jdbcjspservlate/DBConnection.java` so it reads values from environment variables instead of hardcoding credentials.

Suggested environment variables:

- `DB_URL`
- `DB_USER`
- `DB_PASS`

Example values:

- `DB_URL=jdbc:mysql://YOUR_DB_HOST:3306/studentdb`
- `DB_USER=studentapp`
- `DB_PASS=STRONG_PASSWORD_HERE`

## 3) Build the WAR

From the project root:

```bash
mvn clean package
```

The WAR will be created at:

```
target/jdbcjspservlate-1.0-SNAPSHOT.war
```

## 4) Install Tomcat 10.1+

Because your app uses `jakarta.servlet-api 6.1.0`, you need Tomcat 10.1+.

Install Tomcat on your server. After installation, verify Tomcat is running by visiting:

```
http://YOUR_SERVER_IP:8080/
```

## 5) Deploy the WAR

Copy the WAR into Tomcat’s `webapps` directory.

Example (Linux VPS):

```bash
cp target/jdbcjspservlate-1.0-SNAPSHOT.war /opt/tomcat/webapps/
```

Restart Tomcat, then open:

```
http://YOUR_SERVER_IP:8080/jdbcjspservlate/
```

## 6) Configure Environment Variables on the Server

Set the DB environment variables in the Tomcat service configuration.

Example (Linux systemd Tomcat service):

```
Environment=DB_URL=jdbc:mysql://YOUR_DB_HOST:3306/studentdb
Environment=DB_USER=studentapp
Environment=DB_PASS=STRONG_PASSWORD_HERE
```

Restart Tomcat after changes.

## 7) Add HTTPS (Recommended)

Use Nginx or Apache as a reverse proxy and add SSL using Let’s Encrypt.

High-level steps:

- Point your domain to the server IP
- Install Nginx
- Configure proxy to `http://localhost:8080`
- Use Certbot to enable HTTPS

## 8) Verify the App

Open the students list page:

```
http://YOUR_DOMAIN_OR_IP/jdbcjspservlate/student?action=list
```

Test:

- Add a student
- Edit a student
- Delete a student
- Reload and confirm the data persists

## Troubleshooting

- **404 / servlet not found**: verify `web.xml` and servlet mappings
- **DB connection errors**: verify `DB_URL`, firewall rules, DB user access
- **Jakarta errors**: ensure Tomcat 10.1+ (Tomcat 9 will not work)

---

If you want, I can update `DBConnection.java` and add a small `README` section to document environment variables.

