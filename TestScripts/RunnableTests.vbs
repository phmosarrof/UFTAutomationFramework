''RunnableTests.vbs


Sub Test1
'Close Browser
	Call CloseOpenBrowsers
	
	'FB Login
	Call FacebookLogin
	
	' Verify Facebook Find Friends
	Call CheckFindFriendsNav
	
	'Logout FB
	Call FBLogout
	
End Sub


Sub Test2


'Close Browser
	Call CloseOpenBrowsers
	
	'FB Login
	Call FacebookLogin
	
	Call CheckFindFriendsSearch

	Call FBLogout

End Sub


Sub TestDBConnection
	Call CloseOpenBrowsers

	Call DBTest


End Sub



Sub Test3
	Call CloseOpenBrowsers

	Call OpenProthomAlo


End Sub


Sub Test4
	Call CloseOpenBrowsers

	Call OpenMokterHossain


End Sub

