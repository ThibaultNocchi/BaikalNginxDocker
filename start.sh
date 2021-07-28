#!/bin/sh

# PREPARING MSMTP

if [ ! -z "$BAIKAL_SMTP_HOST" ]; then
	echo "Setting up SMTP..."
	cat <<EOF >/etc/msmtprc
# Set default values for all following accounts.
defaults
auth           on
tls            on
tls_starttls   $BAIKAL_SMTP_STARTTLS
tls_trust_file /etc/ssl/certs/ca-certificates.crt
syslog         on

# Mail account
account        baikal
host           $BAIKAL_SMTP_HOST
port           $BAIKAL_SMTP_PORT
from           $BAIKAL_SMTP_FROM
user           $BAIKAL_SMTP_USER
password       $BAIKAL_SMTP_PASS

# Set a default account
account default : baikal

EOF

	cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
	echo "sendmail_path = \"/usr/bin/msmtp -t\"" >>/usr/local/etc/php/php.ini

fi

# START SERVICES

supervisord -c /etc/supervisor/conf.d/supervisord.conf
