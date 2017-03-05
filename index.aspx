<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LABoard</title>
    <style>
        body{
            background: url("Image/Background.png") center center fixed no-repeat;
            background-size: cover;
        }
        #divHead{
            width: 85%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [User]"></asp:SqlDataSource>
    <center>
    <div id="divHead">
        <div style="float:right;">
        <asp:Label ID="lblAccount" style="color:#FFFFFF; " runat="server" Font-Names="微軟正黑體"></asp:Label>
        <asp:Button ID="btnLogOut" runat="server" Text="LogOut" OnClick="btnLogOut_Click" />
        </div>
    </div>
    </center>
    </form>
</body>
</html>
