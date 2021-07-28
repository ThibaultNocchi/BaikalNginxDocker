# Baikal Nginx Docker

This is a simple Docker image for the [Baïkal CalDAV and CardDAV server](https://github.com/sabre-io/Baikal).

It bundles the PHP code along with a simple Nginx configuration to serve it.

Feel free to make a PR or an issue if you feel it is missing something.

## Deploy

The Docker image is currently available on linux/amd64 and linux/arm64.

```bash
docker run \
	-p 8080:8080 \
	ghcr.io/thibaultnocchi/baikal_nginx
```

You can also mount `/app/config` and/or `/app/Specific/db` as volumes to provide and/or backup the config and SQLite database.

To set the email server to send invites, you will have to set those environment variables:

| Variable             | Description                        |
| -------------------- | ---------------------------------- |
| BAIKAL_SMTP_HOST     | SMTP host                          |
| BAIKAL_SMTP_PORT     | SMTP port                          |
| BAIKAL_SMTP_FROM     | Address that will appear as sender |
| BAIKAL_SMTP_USER     | SMTP user                          |
| BAIKAL_SMTP_PASS     | SMTP password                      |
| BAIKAL_SMTP_STARTTLS | Enable STARTTLS (`on` or `off`)    |
