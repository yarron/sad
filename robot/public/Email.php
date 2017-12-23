<?php

class Email {
    protected $core;

    function __construct() {
        $this->core = \Core::getInstance();
    }

    // Get all users
    public function getEmails() {
        $sql = "SELECT * FROM ".DB_PREFIX."newsletter LIMIT 40";

        $prepare = $this->core->dbh->prepare($sql);

        try {
            $prepare->execute();
            $result = $prepare->fetchAll();
        } catch(PDOException $e) {
            $result =  $e->getMessage();
        }

        return $result;
    }

    public function getConfig(){
        $sql = "SELECT s.key, s.value 
          FROM ".DB_PREFIX."setting as s 
          WHERE s.key IN ('config_smtp_port','config_smtp_password','config_smtp_username','config_smtp_host','config_name','config_email')";

        $prepare = $this->core->dbh->prepare($sql);

        try {
            $prepare->execute();
            $result = $prepare->fetchAll();
        } catch(PDOException $e) {
            $result =  $e->getMessage();
        }

        $values = [];

        foreach($result as $row){
            $values[$row['key']] = $row['value'];
        }

        return $values;
    }


    public function removeEmails($emails){
        $ids = [];

        foreach($emails as $email)
            $ids[] = $email['id'];

        $sql = "DELETE FROM ".DB_PREFIX."newsletter WHERE id IN (".implode(',',$ids).')';

        $prepare = $this->core->dbh->prepare($sql);

        try {
            $prepare->execute();
            $result = $prepare->fetchAll();
        } catch(PDOException $e) {
            $result =  $e->getMessage();
        }

        return $result;
    }
}