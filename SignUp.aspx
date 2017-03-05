<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="SignUp" %>

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
            background-color: #3d3d3d;
            border-color: #3d3d3d;
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
            <asp:Label ID="lblUserSignUp" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="XX-Large" Text="USER SIGN UP"></asp:Label>
            <br />
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Image/DotLine.png" Width="50%" />
            <br />
            <br />
            <asp:Label ID="lblUserName" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="帳號"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxAccount" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="lblUserPassword" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="密碼"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxPassword" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="lblName" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="姓名"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxName" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="lblBirthday" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="生日"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxBirthday" runat="server" TextMode="Date"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="lblPhone" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="電話"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxPhone" runat="server" TextMode="Phone"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="lblEmail" runat="server" Font-Bold="True" Font-Names="微軟正黑體" Font-Size="Medium" Text="信箱"></asp:Label>
            <br />
            <asp:TextBox class="tbx" ID="tbxEmail" runat="server" TextMode="Email"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnCancel" runat="server" class="btnBlack" Text="Cancel" OnClick="btnCancel_Click" />　
            <asp:Button ID="btnSignUp" runat="server" class="btnRed" Text="Sign Up" OnClick="btnSignUp_Click" />
            <br />
            <br />
            <asp:Image ID="Image2" runat="server" ImageUrl="~/Image/DotLine.png" Width="50%" />
            <br />
    
    </div>
    </center>
    </form>
</body>
</html>
