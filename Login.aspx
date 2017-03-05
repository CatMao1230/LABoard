<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LABoard</title>
    <style>
        body{
            background: url("Image/LoginBackground.png") center center fixed no-repeat;
            background-size: cover;
        }
        .tbx{
            background-color: #FFFFFF;
            border-color: #aaaaaa;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
            width: 50%;
            height: 25px;
        }
        #divMain{
            height: 50%;
            width: 30%;
        }
        .btnBlack{
            background-color: #000000;
            border-color: #000000;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
            width: 20%;
            height: 30px;
            color: #FFFFFF;
        }
        .btnRed{
            background-color: #FF2040;
            border-color: #FF2040;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
            width: 20%;
            height: 30px;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <center>
    <div id="divMain">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [User]"></asp:SqlDataSource>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="lblUserSignIn" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="XX-Large" Text="USER SIGN IN"></asp:Label>
            <br />
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Image/DotLine.png" Width="50%" />
            <br />
            <br />
            <asp:Label ID="lblUserName" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="USERNAME"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxAccount" runat="server"></asp:TextBox><br />
            <br />
            <asp:Label ID="lblUserName0" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="PASSWORD"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxPassword" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <br />
            <asp:Button class="btnBlack" ID="btnSignUp" runat="server" OnClick="btnSignUp_Click" Text="Sign Up" />　
            <asp:Button class="btnRed" ID="btnSignIn" runat="server" OnClick="btnLogin_Click" Text="Sign In" />
            <br />
            <br />
            <asp:Image ID="Image2" runat="server" ImageUrl="~/Image/DotLine.png" Width="50%" />
            <br />
            <asp:Label ID="lblResult" runat="server" Font-Size="Small" ForeColor="#FF2040"></asp:Label>
    </div>
    </center>
    </form>
</body>
</html>
