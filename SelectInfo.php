<?php
    include 'Connect.php';

    if(isset($_GET['id']))
    {
        $id = $_GET['id'];
        $query = "SELECT username, password, email, Description, created from Users WHERE id = $id";
        
        $result = mysqli_query($db, $query);
        $row = mysqli_fetch_assoc($result);
        
        $user = array();
        array_push($user, array(
            "Username" => $row['username'],
            // "Password" => $row['password'],
            "Email" => $row['email'],
            "Description" => $row['Description'],
            "Date" => $row['created'],
        ));
     
        echo json_encode($user);
    }
    else
    {
        echo son_encode("Fout: geen id opgegeven via GET");
    } 
?>