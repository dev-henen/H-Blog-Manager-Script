# H-Blog-Manager-Script

H-Blog-Manager-Script is a robust blog management script that caters to developers and administrators. It provides a flexible environment for customizations, efficient content management, and seamless integration of templates.

## Features

### Developers:

- **Custom Templates:**
  - Developers can edit `.tpl` files in the "tmpl" folder for website templates.
  - Build custom email template by editing `email_template.html` in the root folder.
  - Define custom designs, media, and content for templates.

### Admin Management:

- **Dashboard and Login:**
  - Admin dashboard for an overview of site activity.
  - Secure login page for administrator.

- **Content Management:**
  - Create, edit, and delete posts and custom pages.
  - Set feature posts and add media files (images and videos).
  - User management, newsletters, and more.

- **User Features:**
  - Visitors can subscribe/unsubscribe from newsletters.
  - Read posts and utilize search functionality.

### System Requirements:

- PHP 7 and above.
- MySQL Database (compatible version required).
- Rename the file: "RENAME_THIS_FILE.htaccess" to ".htaccess" or use the ziped file

### Database Configuration:

In the `index.php` file, set up the database connection:

```php
$database = new Database\Connection('database_host', 'database_user', 'database_password', 'database_name');
```

### Additional Setup:

1. Execute the MySQL database schema using `sql/Database.sql`.
2. Set a strong encryption key in `index.php`:
   ```php
   $GLOBALS['encryption_key'] = 'your_strong_key';
   ```
3. Set the no-reply email address for sending emails:
   ```php
   $GLOBALS['webmaster'] = 'webmaster@email.com';
   ```

### Default Admin Login:

- Email: `admin@webmaster.com`
- Password: `password`

Upon initial login, change the default password for security reasons.

### Template Creation Guidelines:

- When creating templates for the application, developers should:
  - Use meaningful tags and IDs for elements.
  - Keep the predefined IDs and classes unchanged.

### Sitemaps and RSS Feed:

- Automatically generated sitemaps at the root folder:
  - `sitemap.pages.txt` for pages.
  - `sitemap.posts.txt` for posts.
- RSS feed:
  - `rss.xml` at the root folder.

### Contact Information:

For assistance and support, contact Moses Henen:

- Facebook: [HenenTheProgrammer](https://facebook.com/HenenTheProgrammer)
- GitHub: [HenenTheProgrammer](https://github.com/HenenTheProgrammer)
- LinkedIn: [HenenTheProgrammer](https://linkedin.com/in/HenenTheProgrammer)
- Instagram: [HenenTheProgrammer](https://instagram.com/henentheprogrammer)
- Email: [henen.programmer@proton.me](mailto:henen.programmer@proton.me)

### Additional Resources:

- Explore additional templates on [HenenTheProgrammer Templates](https://github.com/HenenTheProgrammer).
- Learn template parsing at [Template Parsing Guidelines](https://github.com/HenenTheProgrammer/php_template_loader).

Feel free to explore and enhance the capabilities of H-Blog-Manager-Script!
```

