<?php

class Core {
    public $dbh; // handle of the db connexion
    private static $instance;

    private function __construct() {
        $dsn = 'mysql'.
            ':host=' .DB_HOSTNAME .
            ';dbname='    . DB_DATABASE .
            ';port='      . DB_PORT .
            ';connect_timeout=15';

        $user = DB_USERNAME;
        $password = DB_PASSWORD;

        //опции подключения
        $opt = array(
            PDO::ATTR_ERRMODE               => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE    => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES      => true,
            PDO::MYSQL_ATTR_INIT_COMMAND    => "SET NAMES utf8"
        );


        $this->dbh = new PDO($dsn, $user, $password,$opt);
    }

    public static function getInstance() {
        if (!isset(self::$instance))
        {
            $object = __CLASS__;
            self::$instance = new $object;
        }
        return self::$instance;
    }

    // others global functions
}