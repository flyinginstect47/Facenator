<?php 
    include 'connect.php';

    $username = $_POST['username'];
    $password = $_POST['password'];

    $password = md5($password); //password encryptie

    $sql = "SELECT * FROM Users WHERE username = '".$username."' AND password = '".$password."' ";
    // echo $sql;
    $result = mysqli_query($db, $sql);
    $count = mysqli_num_rows($result);

    if($count >= 1) 
    {
        echo json_encode("success");
    }
    else
    {
        echo json_encode("error");
    }
?>