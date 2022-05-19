<?php
    include 'connect.php';

    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];

    $password = md5($password); //password encryptie

    $sql = "INSERT INTO Users (username, password, email) VALUES ('{$username}', '{$password}', '{$email}')";
    $query = mysqli_query($db, $sql);

    if($query)
    {
        echo json_encode("success");
    }
?>