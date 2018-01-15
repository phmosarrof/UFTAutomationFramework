'ReusableFunctions.vbs

Function CloseOpenBrowsers
		
With Browser("creationtime:=0")
While .Exist(1)
'Close the browser
.Close
Wend
End With

End Function



Function OpenMokterHossain
	
''Systemutil.Run "IExplore.exe", "http://www.google.com/"
Systemutil.Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe", "http://www.google.com/"
wait(2)
Set oBrowser=Browser("micclass:=Browser").Page("micclass:=Page")
With oBrowser
'
	.WebEdit("acc_name:=Search").Set "Md Mokter Hossain"
	wait(2)
	.WebButton("acc_name:=Google Search","value:=Search").Click
	wait(2)
	.Link("innertext:=Md Mokter Hossain - Google Scholar Citations").Click
    ''.Link("innertext:=Md Mokter Hossain | Computer Science and Mathematics Educator ...").Click

	wait(2)
End With

End Function


Function CloseAllOpenBrowsers
Set oBrowser = Description.Create
oBrowser.Add "micClass","Browser"

Set oBrowserCol = Desktop.ChildObjects(oBrowser)

For i = 1 To oBrowserCol.Count - 1
	oBrowserCol(i).Close
	
Next

End Function


Function FacebookLogin
	
'Systemutil.Run "https://www.facebook.com/"
wait(2)
Set oBrowser=Browser("micclass:=Browser").Page("micclass:=Page")
With oBrowser

.WebEdit("html id:=email").Set DataTable.Value("UserName")
wait(1)
.WebEdit("html id:=pass").Set DataTable.Value("Password")
wait(1)
.WebButton("name:=Log In").Click
wait(2)
End With
End Function


Function OpenProthomAlo
	
Systemutil.Run "http://www.prothom-alo.com/"
wait(2)
Set oBrowser=Browser("micclass:=Browser").Page("micclass:=Page")
With oBrowser
''  .//*[@id='home_page_search_form']/div/input

.WebElement("text:=English").Click
'' .//*[@id='home_page_search_form']/input

wait(2)
End With

End Function


Function FBLogout

	Browser("micclass:=Browser").Page("micclass:=Page").WebElement("html id:=userNavigationLabel").Click
		wait(2)
	
		Browser("micclass:=Browser").Page("micclass:=Page").Link("name:=Log Out").Click
	wait 2
	
	Browser("micclass:=Browser").Close

End Function


Function CheckFindFriendsNav

	'Verify  Find Friends
		Set oBrowser=Browser("micclass:=Browser").Page("micclass:=Page")
	sName=oBrowser.WebElement("html id:=findFriendsNav").GetROProperty("innertext")
	If sName="Find Friends" Then
	'msgbox "Yes"
	Reporter.ReportEvent micPass,"The Find Friends is available"," Yes, the Find Friends is available"
	Else
	'msgbox "No"
	Reporter.ReportEvent micFail,"The Find Friends is not available","No,the Find Friends is not available"
	End If
	
End Function


Function ClickSearchFriend
	'Verify  Find Friends
	Set oBrowser=Browser("micclass:=Browser").Page("micclass:=Page")
	oBrowser.WebButton("Search").Click
	
	
	'Verify Find in the FriendList
	Set oBrowser=Browser("micclass:=Browser").Page("micclass:=Page")
	fName=oBrowser.WebElement("html id:=js_2b").GetROProperty("innertext")
	If fName=sName Then
	'msgbox "Yes"
	Reporter.ReportEvent micPass,"The Friend is available"," Yes, the Friend is available"
	Else
	'msgbox "No"
	Reporter.ReportEvent micFail,"The Friend is not available","No,the Friend is not available"
	End If

	
End Function


Function CheckFindFriendsSearch
	
Dim xlApp, xlBook, xlSheet
Dim iRow, sControl, sPlayerID, sResult
CONST iControlCol = 1	'Control is in Column A
CONST iNameCol = 2	'Date is in Column B
CONST iResultCol = 3	'Result is in Column C

Dim fName
	
'Dim mySendKeys
'set mySendKeys = CreateObject("WScript.shell")
'mySendKeys.SendKeys(“{TAB}”)
'mySendKeys = Nothing

Set xlApp = CreateObject("Excel.Application")
Set xlBook = xlApp.WorkBooks.Open("C:\UFTDemo\UFTAutomationFramework\FBExcelData.xls")
Set xlSheet = xlBook.WorkSheets("Sheet1")
 
'Loop 2 to entire rows
For iRow = 2 to xlSheet.UsedRange.Rows.Count
 
   'Retrieve Control ,Date and PlayerID from "iRow" rows and columns A, B & C
   sControl = xlSheet.Rows(iRow).Columns(iControlCol).Value
   sName = xlSheet.Rows(iRow).Columns(iNameCol).Value
   print "sName: " + sName
   
   'sResult = xlSheet.Rows(iRow).Columns(iResultCol).Value
	'fName= xlSheet.Rows(iRow).Columns(iResultCol).Value
	
	
'Execute if Contol value is y

 If UCase(sControl)="Y" Then


Browser("micclass:=Browser").Page("micclass:=Page").Link("html id:=findFriendsNav").Click
wait 2
'Browser("micclass:=Browser").Page("micclass:=Page").WebEdit("class:=_1frb").Click

'wait 1
Browser("micclass:=Browser").Page("micclass:=Page").WebEdit("class:=_1frb").Set sName
wait 1

Browser("micclass:=Browser").Page("micclass:=Page").WebEdit("class:=_1frb").Submit

'fName= Browser("micclass:=Browser").Page("micclass:=Page").Link("class:=_2yez").GetROProperty("innertext")


fName= Browser("micclass:=Browser").Page("micclass:=Page").Link("xpath:=//DIV[@id='BrowseResultsContainer']/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/DIV[1]/DIV[1]/A[1]").GetROProperty("innertext")

                                                                       

print "fName: " + fName

wait 1

print StrComp(fName, sName)

	If  StrComp(fName, sName)=0 Then
	'msgbox "Yes"
	'Reporter.ReportEvent micPass,"The Friend is available"," Yes, the Friend is available"
	xlApp.Cells(iRow,iResultCol)="Found"
	
	Else
	'msgbox "No"
	'Reporter.ReportEvent micFail,"The Friend is not available","No,the Friend is not available"
	xlApp.Cells(iRow,iResultCol)="Not Found"
	
	End If

'Call ClickSearchFriend

'xlApp.Cells(iRow,iResultCol)="Pass"
End if
'xlBook.Save
Next

xlBook.Save 
xlBook.Close
xlApp.Quit
Set xlSheet = Nothing
Set xlBook = Nothing
Set xlApp = Nothing


End Function




Function CheckFindFriendsDBSearch

'<property name="url"

'value="jdbc:mysql://iadjustertest.can6aqqzvhtp.us-west-2.rds.amazonaws.com:3306/iadjustertest?autoReconnect=true" />

'<property name="username" value="iadjustertest" />

'<property name="password" value="iadjustertest" />


sConnection="DRIVER={MySQL ODBC 5.3 ANSI};SERVER=iadjustertest.can6aqqzvhtp.us-west-2.rds.amazonaws.com;Port=3306;DATABASE=iadjustertest;uid=iadjustertest;pwd=iadjustertest" 
'Connect to the  Database
 Set objRecSet=CreateObject("jdbc.RecordSet")
 Set objCommand = CreateObject ("jdbc.Command")
 objCommand.ActiveConnection =	sConnection

 ' source query
 strQuery="SELECT userid, username, password From FBuser"			
 objCommand.CommandText = strQuery 
 objCommand.CommandTimeout = 0
 Set objRecSet=objCommand.Execute()

' Loop through all records
 While Not objRecSet.EOF 
 
 userid=objRecSet.fields("userid")
 username=objRecSet.fields("username")
 password=objRecSet.fields("password")

Browser("micclass:=Browser").Page("micclass:=Page").Link("html id:=findFriendsNav").Click
wait 2
'Browser("micclass:=Browser").Page("micclass:=Page").WebEdit("class:=_1frb").Click

'wait 1
Browser("micclass:=Browser").Page("micclass:=Page").WebEdit("class:=_1frb").Set username
wait 1

Browser("micclass:=Browser").Page("micclass:=Page").WebEdit("class:=_1frb").Submit


sFName= Browser("micclass:=Browser").Page("micclass:=Page").Link("xpath:=//DIV[@id='BrowseResultsContainer']/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/DIV[1]/DIV[1]/A[1]").GetROProperty("innertext")

                                                                       

print "FName: " + sFName

wait 1

print StrComp(FName, sFName)

	If  StrComp(FName, sFName)=0 Then
	'msgbox "Yes"
	Reporter.ReportEvent micPass,"The Friend is available"," Yes, the Friend is available"
	
	
	Else
	'msgbox "No"
	Reporter.ReportEvent micFail,"The Friend is not available","No,the Friend is not available"
	End If

Wend


End Function


Sub DBTest

sConnection="DRIVER={MySQL ODBC 5.3 ANSI Driver};SERVER=iadjustertest.can6aqqzvhtp.us-west-2.rds.amazonaws.com;Port=3306;DATABASE=iadjustertest;uid=iadjustertest;pwd=iadjustertest" 
'Connect to the  Database

'sConnection="Dsn=iadjustertest;uid=iadjustertest;pwd=iadjustertest" 

 Set objRecSet=CreateObject("ADODB.RecordSet")
 Set objCommand = CreateObject ("ADODB.Command")
 objCommand.ActiveConnection =	sConnection
 
 ' source query
 strQuery="SELECT userid, username,  password FROM iadjustertest.FBuser"			
 objCommand.CommandText = strQuery 
 objCommand.CommandTimeout = 0
 Set objRecSet=objCommand.Execute()

' Loop through all records
 While Not objRecSet.EOF 
 
 suserid=objRecSet.fields("userid")
 susername=objRecSet.fields("username")
 spassword=objRecSet.fields("password")

 print suserid
 print susername
 print spassword
 	
	Systemutil.Run "https://www.facebook.com/"
	wait(2)
	
	Browser("micclass:=Browser").Page("micclass:=Page").Close
	
	'Set oBrowser=Browser("micclass:=Browser").Page("micclass:=Page")
'	With oBrowser
'
'		.WebEdit("html id:=email").Set susername
'		wait(1)
'		.WebEdit("html id:=pass").Set spassword
'		wait(1)
'	'	.WebButton("name:=Log In").Click
'		wait(2)
'		.Close
'		
'	End With

''	Call FBLogout
	wait(5)
 objRecSet.MoveNext
 Wend
 
End Sub
