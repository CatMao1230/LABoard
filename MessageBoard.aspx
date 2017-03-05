<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MessageBoard.aspx.cs" Inherits="MessageBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LABoard</title>
    <style>
        body{
            margin:0;
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
        #divMB{
            width: 50%;
        }
        .divMessage{
            text-align: left;
            padding: 10px;
            border-color: #eeeeee;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
            box-shadow:4px 4px 3px rgba(20%,20%,40%,0.1);
        }
        .btnBlack{
            background-color: #3d3d3d;
            border-color: #3d3d3d;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
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
        <asp:SqlDataSource ID="SDSMessage" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [MessageBoard] ORDER BY [Datetime] DESC"></asp:SqlDataSource>
    <div id="divAll">
    <center>
    <div id="divHead">
        <ul>
            <li><asp:HyperLink ID="aMessageBoard" class="active" runat="server" NavigateUrl="MessageBoard.aspx">留言板</asp:HyperLink></li>
            <li><asp:HyperLink ID="aBookMeal" runat="server" NavigateUrl="BookMeal.aspx">餐點</asp:HyperLink></li>
            <li><asp:HyperLink ID="aFund" runat="server" NavigateUrl="Fund.aspx">記帳</asp:HyperLink></li>
            <li><asp:HyperLink ID="aToDoList" runat="server" NavigateUrl="ToDoList.aspx">待辦事項</asp:HyperLink></li>
            <li><asp:HyperLink ID="aDirectory" runat="server" NavigateUrl="Directory.aspx">通訊錄</asp:HyperLink></li>
            <li><asp:HyperLink ID="aStuff" runat="server" NavigateUrl="Stuff.aspx">物品清單</asp:HyperLink></li>
            <li><asp:HyperLink ID="aManager" runat="server" NavigateUrl="Manager.aspx" Visible="False">帳號管理</asp:HyperLink></li>
            <li style="float:right; padding: 14px 16px;"><asp:ImageButton ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" ImageUrl="~/Image/LogOut.png" Width="2em" /></li>
            <li style="float:right;"><asp:HyperLink ID="lblAccount" runat="server" NavigateUrl="User.aspx"></asp:HyperLink></li>
            <li style="float:right; padding: 10px 0px;"><asp:Image ID="imgUser" runat="server" ImageUrl="~/Image/Guest.png" style="width: 2em; height: 2em;border-radius: 1em;-webkit-border-radius: 1em;-moz-border-radius: 1em;"></asp:Image></li>
        </ul>
    </div>
    <div id="divMain">
        <div id="divMB">
        <asp:Label ID="lblMessageBoard" runat="server" Font-Size="XX-Large" Text="留言板"></asp:Label>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <br />
        <br />
        <div class="divMessage">
            <asp:Image ID="imgPicture" style="width: 5%;" runat="server" ImageUrl="~/Image/Guest.png"></asp:Image>
            <asp:Label ID="lblName" runat="server" Text=""></asp:Label>

            <br />
            <asp:TextBox ID="tbxMessage" runat="server" Height="60px" Width="100%" TextMode="MultiLine"></asp:TextBox><br />
            <div style="width:100%; text-align:right;">
            <asp:Button class="btnBlack" ID="btnSubmit" runat="server" Text=" 送出 " OnClick="btnSubmit_Click" Font-Names="微軟正黑體"></asp:Button></div>
        </div>
        <br />
        <br />
        <asp:ListView ID="lvMessage" runat="server" DataSourceID="SDSMessage" OnItemDataBound="lvMessage_ItemDataBound" DataKeyNames="id">
            <EmptyDataTemplate>
                <span>未傳回資料。</span>
            </EmptyDataTemplate>
            <ItemTemplate>
                <div class="divMessage">
                <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>' Visible="False" />
                <asp:Image ID="imgPic" style="height: 2em; width: 2em;" runat="server" ImageUrl="~/Image/Guest.png"></asp:Image>
                <span style="color:#666666;">
                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Account") %>' />　
                <asp:Label ID="lblDatetime" runat="server" Text='<%# Eval("Datetime") %>' />　
                <asp:ImageButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" ImageUrl="~/Image/Delete.png" Width="1em" Visible="False"></asp:ImageButton>
                </span><br />
                <asp:Label ID="lblMessage" runat="server" Text='<%# Eval("Message") %>' />
                <br />
                </div>
                <br />
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="">
                    <asp:DataPager ID="DataPager1" runat="server">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonCssClass="btnBlack" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"/>
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ButtonCssClass="btnBlack" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"/>
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
        </asp:ListView>
        </ContentTemplate>
        </asp:UpdatePanel>
        </div>
    </div>
    </center>
    </div>
    </form>
</body>
</html>
