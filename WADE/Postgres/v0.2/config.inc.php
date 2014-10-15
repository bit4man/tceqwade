<?php
/*    $dsn = getenv('OPENSHIFT_POSTGRESQL_DB_URL'); */
    $dsn = 'postgres9://wade_app1:wade_app1@' . getenv('OPENSHIFT_POSTGRESQL_DB_HOST') . ':5432/' . getenv('OPENSHIFT_APP_HOST') . '?persist';
?>

