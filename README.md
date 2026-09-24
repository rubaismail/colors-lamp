# COLORS LAMP application

COLORS is a small web application completed for the COP 4331 COLORS Lab. A user signs in with an existing account, adds color names to their list, searches their saved colors by a partial name, and logs out. The browser sends JSON requests to PHP endpoints; MySQL stores users and colors.

## Live website

[Open the COLORS application](http://cop4331c.space/index.html). Sign in with an existing lab account to add and search colors. No local setup is needed to use the deployed website.

## Technologies

- Linux and Apache (the lab deployment uses Ubuntu and Apache 2.4)
- PHP 8.3 with the MySQLi extension and mysqlnd (`get_result` support)
- MySQL
- HTML, CSS, and vanilla JavaScript with XMLHttpRequest

## Repository layout

```text
LAMPAPI/
  database.php       Shared connection helper
  Login.php          Account lookup
  AddColor.php       Save a color for a user
  SearchColors.php   Search a user's colors
css/styles.css
js/code.js
js/md5.js
images/background.png
index.html           Login page
color.html           Color management page
database/schema.sql  Schema only, without user data
.gitignore
README.md
LICENSE.md
```

The existing lab paths are retained so the deployed URLs continue to work. The repository root is the web document root. Real database configuration belongs outside that root and is never committed.

## Setup

1. Install Apache, PHP with MySQLi/mysqlnd, and MySQL on a Linux machine. Ensure Apache executes PHP rather than serving PHP source.
2. Clone this repository into your chosen application directory. Configure Apache to serve that directory, with `index.html` as an index page. Keep Git metadata outside the document root or explicitly deny web access to it.
3. Create a new MySQL database and a dedicated application database user. Give that user SELECT access to Users and SELECT/INSERT access to Colors. Import the empty schema into the new database, for example:

   ```bash
   mysql -u YOUR_ADMIN_USER -p YOUR_DATABASE < database/schema.sql
   ```

   Do not import this schema over an existing lab database. It contains no accounts or deployed records.
4. Create `colors-config.php` in the **parent directory of the application directory**. Its contents are a PHP array in this order (replace all placeholders locally):

   ```php
   <?php
   return ['localhost', 'YOUR_DB_USER', 'YOUR_DB_PASSWORD', 'YOUR_DATABASE'];
   ```

   Make the file readable by the PHP process and restrict access to other users. Alternatively, set `COLORS_CONFIG_PATH` in the PHP process environment to the absolute path of this private file. An `.env` file is not loaded automatically.
5. Provision a disposable lab account directly in the Users table using a database administration tool. Supply FirstName, LastName, Login, and Password; ID is generated automatically. This version compares the submitted password directly with the stored value. There is no registration page. Do not use a real or reused password, and do not commit account data.
6. Start MySQL and Apache, then open your configured site's `/index.html`. Sign in, add a color on `color.html`, search for part of its name, and use Log Out to return to the login page. The frontend uses the relative `LAMPAPI` path, so the pages and API must be served together.

For local development after configuring PHP, MySQL, and the private config file, run this from the repository root:

```bash
php -S 127.0.0.1:8000 -t .
```

After starting that command on your own computer, open `http://127.0.0.1:8000/index.html` in its browser. `127.0.0.1` means your own computer, not the deployed server; this address only works while your local PHP server is running. To use the deployed application, use the live website link above. PHP's development server is for local testing only. Opening HTML with a `file://` URL will not run the backend.

## API overview

All endpoints accept POST requests containing JSON.

| Endpoint | Request fields | Purpose |
| --- | --- | --- |
| `LAMPAPI/Login.php` | `login`, `password` | Return account ID and first/last name, or an error |
| `LAMPAPI/AddColor.php` | `color`, `userId` | Insert a color for that user |
| `LAMPAPI/SearchColors.php` | `search`, `userId` | Return matching color names, or `No Records Found` |

## Assumptions and limitations

This repository documents the completed educational lab, not a production authentication system. Passwords are compared directly, login state is stored in a browser cookie, and color endpoints trust the supplied user ID without server-side session authorization. The app lacks robust validation and escaping; manually assembled JSON and HTML may fail on special characters. 

Users must already exist in MySQL. Search is a SQL substring match; case sensitivity depends on database collation. 
## Version history and AI usage

The application was completed and deployed before this repository was created. Its initial commits organize that existing work into project/API setup, backend endpoints, frontend integration, and documentation stages; they are not a claim about the original development dates.
