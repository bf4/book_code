 <?
	// Geolocation Device Locator PHP Script
	// Writing to a text file on a web server
	if(isset($_GET['get']))	 //(1)
	{
		$filename = $_GET['get'].".txt";	 //(2)
	   	if(file_exists($filename))	 //(3)
		{
			$file = file_get_contents($filename);	 //(4)
		   	echo $file;	 //(5)
		} else 
		   	echo "ERROR! No location found for " . $_GET['get'];
	}
	//if the request is an update, we dump the location into a file
	// named after the device making the request
	else if(isset($_GET['update']) && isset($_GET['location']))	//(6)
	{
		$fh =fopen($_GET['update'].".txt", "w");	//(7)
		if($fh == FALSE)
		{
			echo "ERROR.  Cannot open file on server.";
			return;
		}
		if(fwrite($fh, $_GET['location']."\n") == FALSE)	//(8)
			echo "ERROR. Writing to file.";
		if(fclose($fh) == FALSE)	//(9)
		   echo "ERROR. Closing file,";
	}
 ?>