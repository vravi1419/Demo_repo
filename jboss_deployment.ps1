function jboss_start
	 {
	 #set b="D:\JBoss-EAP\bin\standalone.bat"
     start-job {D:\JBoss-EAP\bin\standalone.bat}
     #.$b
     Start-Sleep -Seconds 10
     #return 0
	 }
	 function jboss_stop
	 {
	 jboss-cli.bat --connect --controller=localhost:8990 --command=:shutdown
     Start-Sleep -Seconds 10
	 }
	 function jboss_status
	 {
	 set a="D:\JBoss-EAP\bin\jboss-cli.bat --connect --controller=localhost:8990 --command="read-attribute server-state""
	 write-output $a
	 return $a
	 }
	 function copy_file
	 {
	 Write-Output("copying pom file")
	 Copy-Item "D:\Demo_new\pom.xml" "D:\JBoss-EAP\standalone\deployments\"
	 Write-Output("copying pom file is completed")
	 }
	 jboss_status
	 if ( $a -eq "running" )
	 {
	 write-host("jboss is running")
	 write-output("stopping jboss to do deployment")
	 jboss_stop
	 copy_file
     Start-Sleep -Seconds 10
     jboss_start
     }
	 else
	 {
	 write-output("jboss is stopped")
	 copy_file
     Start-Sleep -Seconds 10
     jboss_start
	 }