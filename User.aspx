<%@ Page Language="C#" AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="User" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LABoard</title>
    <style>
        body{
            margin: 0;
            background: url("Image/Background2.png") center center fixed no-repeat;
            background-size: cover;
            font-family: "微軟正黑體";
        }
        #divAll{
            width: 100%;
        }
        #divHead{
            position: absolute;
            width: 100%;
            height: 10%;
        }
        #divMain{
            position: absolute;
            top: 15%;
            left: 9%;
            width: 82%;
            height: 80%;
            overflow-y:auto;
        }
        #divProfile{
            width: 70%;
        }
        #imgPicture{
            border-color: #ffffff;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
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
        .tbxLock{
            background-color: #EEEEEE;
            border-color: #aaaaaa;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
            width: 50%;
            height: 25px;
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

        #divHead ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: transparent;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
        }
        #divHead li {
            float: left;
        }
        #divHead li:last-child {
            border-right: none;
        }
        #divHead li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        #divHead Button{
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        #divHead li a:hover:not(.active) {
            background-color: transparent;
        }
        #divHead .active {
            background-color: #FFFFFF;
            color: #000000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [User]"></asp:SqlDataSource>
    <div id="divAll">
    <center>
    <div id="divHead">
        <ul>
            <li><asp:HyperLink ID="aMessageBoard" runat="server" NavigateUrl="MessageBoard.aspx">留言板</asp:HyperLink></li>
            <li><asp:HyperLink ID="aBookMeal" runat="server" NavigateUrl="BookMeal.aspx">餐點</asp:HyperLink></li>
            <li><asp:HyperLink ID="aFund" runat="server" NavigateUrl="Fund.aspx">記帳</asp:HyperLink></li>
            <li><asp:HyperLink ID="aToDoList" runat="server" NavigateUrl="ToDoList.aspx">待辦事項</asp:HyperLink></li>
            <li><asp:HyperLink ID="aDirectory" runat="server" NavigateUrl="Directory.aspx">通訊錄</asp:HyperLink></li>
            <li><asp:HyperLink ID="aStuff" runat="server" NavigateUrl="Stuff.aspx">物品清單</asp:HyperLink></li>
            <li><asp:HyperLink ID="aManager" runat="server" NavigateUrl="Manager.aspx" Visible="False">帳號管理</asp:HyperLink></li>
            <li style="float:right; padding: 14px 16px;"><asp:ImageButton ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" ImageUrl="~/Image/LogOut.png" Width="2em" /></li>
            <li style="float:right;"><asp:HyperLink class="active" ID="lblAccount" runat="server" NavigateUrl="User.aspx"></asp:HyperLink></li>
            <li style="float:right; padding: 10px 0px;"><asp:Image ID="imgUser" runat="server" ImageUrl="~/Image/Guest.png" style="width: 2em; height: 2em;border-radius: 1em;-webkit-border-radius: 1em;-moz-border-radius: 1em;"></asp:Image></li>
        </ul>
    </div>
    <div id="divMain">
        <div id="divProfile">
        <asp:Label ID="lblProfile" runat="server" Font-Size="XX-Large" Text="個人資料"></asp:Label>
        <br />
        <br />
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
        <br />
            <div style="width: 35%; float:left;"><asp:Image ID="imgPicture" runat="server" Width="100%" ImageUrl="~/Image/Guest.png" /></div>
            
            　<div style="width: 60%; float: right; text-align: center;">
                <asp:Label ID="lblID" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lblAccount1" runat="server" Text="帳號："></asp:Label>
                <asp:TextBox class="tbxLock" ID="tbxAccount" runat="server" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lblPassword" runat="server" Text="密碼："></asp:Label>
                <asp:TextBox class="tbx" ID="tbxPassword" runat="server" TextMode="Password"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lblName" runat="server" Text="姓名："></asp:Label>
                <asp:TextBox class="tbx" ID="tbxName" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lblBirthday" runat="server" Text="生日："></asp:Label>
                <asp:TextBox class="tbxLock" ID="tbxBirthday" runat="server" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lblTel" runat="server" Text="電話："></asp:Label>
                <asp:TextBox class="tbx" ID="tbxTel" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lblEmail" runat="server" Text="信箱："></asp:Label>
                <asp:TextBox class="tbx" ID="tbxEmail" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lblRank" runat="server" Text="階級："></asp:Label>
                <asp:TextBox ID="tbxRank" runat="server" class="tbxLock" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
                <asp:Button AutoPostBack="True" class="btnBlack" ID="btnSubmit" runat="server" Text="修改" OnClick="btnSubmit_Click" />
                <br />
            </div><br />
        </ContentTemplate></asp:UpdatePanel>
        </div>
    </div>
    </center>
    </div>
    </form>
</body>
</html>
