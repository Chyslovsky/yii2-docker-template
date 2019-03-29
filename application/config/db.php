<?php

return [
    'class' => 'yii\db\Connection',
    'dsn'          => 'mysql:host=' . getenv('MYSQL_HOST') . ';dbname=' . getenv('MYSQL_DATABASE'),
    'username'     => getenv('MYSQL_USER'),
    'password'     => getenv('MYSQL_PASSWORD'),
    'charset' => 'utf8',
    'on afterOpen' => function ($event) {
        $event->sender->createCommand("SET time_zone='Europe/Kiev';")->execute();
    },

    // Schema cache options (for production environment)
    //'enableSchemaCache' => true,
    //'schemaCacheDuration' => 60,
    //'schemaCache' => 'cache',
];
