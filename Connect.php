<?php
    $db = mysqli_connect('localhost', 'root', '', 'localconnect');
    if(!$db){
        echo "Database connection failed!";
    }
?>