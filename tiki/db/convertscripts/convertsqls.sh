#!/bin/sh
# $Header: /cvsroot/tikiwiki/tiki/db/convertscripts/convertsqls.sh,v 1.6 2004-07-15 19:29:08 teedog Exp $


if [ -z $1 ]; then
	echo "Usage: ./convertscript.sh <host>"
	echo "       where <host> is the virtualhost/root/ for your tiki"
	exit 0
fi

TIKISERVER=$1
VERSION="1.10"

wget -O pgsql72..sql.tmp "http://$TIKISERVER/db/convertscripts/mysql3topgsql72.php?version=$VERSION" 
wget -O sybase.sql.tmp "http://$TIKISERVER/db/convertscripts/mysql3tosybase.php?version=$VERSION" 
wget -O sqlite.sql.tmp "http://$TIKISERVER/db/convertscripts/mysql3tosqlite.php?version=$VERSION"
wget -O oci8.sql.tmp "http://$TIKISERVER/db/convertscripts/mysql3tooci8.php?version=$VERSION" 

rm -f *.sql.tmp 
rm -f ../tiki-$VERSION-*.sql

cp ../tiki.sql ../tiki-$VERSION-mysql.sql
mv $VERSION.to_pgsql72.sql ../tiki-$VERSION-pgsql.sql
mv $VERSION.to_sybase.sql ../tiki-$VERSION-sybase.sql
mv $VERSION.to_sqlite.sql ../tiki-$VERSION-sqlite.sql
mv $VERSION.to_oci8.sql ../tiki-$VERSION-oci8.sql


echo "Done."
exit 0
