<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Manager.aspx.cs" Inherits="Manager" %>

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
        #divManager{
            width: 80%;
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
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        th{
            background-color: #FF2040;
            color: #ffffff;
        }
        .tbx{
            background-color: #FFFFFF;
            border-color: #aaaaaa;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
            width: 90%;
            height: 1.5em;
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [User] ORDER BY [Rank] DESC"></asp:SqlDataSource>
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
            <li><asp:HyperLink ID="aManager" class="active" runat="server" NavigateUrl="Manager.aspx" Visible="False">帳號管理</asp:HyperLink></li>
            <li style="float:right; padding: 14px 16px;"><asp:ImageButton ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" ImageUrl="~/Image/LogOut.png" Width="2em" /></li>
            <li style="float:right;"><asp:HyperLink ID="lblAccount" runat="server" NavigateUrl="User.aspx"></asp:HyperLink></li>
            <li style="float:right; padding: 10px 0px;"><asp:Image ID="imgUser" runat="server" ImageUrl="~/Image/Guest.png" style="width: 2em; height: 2em;border-radius: 1em;-webkit-border-radius: 1em;-moz-border-radius: 1em;"></asp:Image></li>
        </ul>
    </div>
    <div id="divMain">
        <div id="divManager">
        <asp:Label ID="lblManager" runat="server" Font-Size="XX-Large" Text="帳號管理"></asp:Label>
        <br />
            <br />
        <br />
            <asp:Label ID="lblError" runat="server" Text="權限不足，無法觀看。"></asp:Label>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            <asp:ListView ID="lvAccount" runat="server" DataKeyNames="id" DataSourceID="SqlDataSource1" OnItemDataBound="lvAccount_ItemDataBound" Visible="False">
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>未傳回資料。</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("id") %>' Visible="False" />
                            <asp:Label ID="lblAccount" runat="server" Text='<%# Eval("Account") %>' />
                            <asp:TextBox class="tbx" ID="tbxAccount" runat="server"  Text='<%# Eval("Account") %>' Visible="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblPassword" runat="server" Text='' />
                            <asp:TextBox class="tbx" ID="tbxPassword" runat="server"  Text='' Visible="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>' />
                            <asp:TextBox class="tbx" ID="tbxName" runat="server" Text='<%# Eval("Name") %>' Visible="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblBirthday" runat="server" Text='<%# Eval("Birthday") %>' />
                            <asp:TextBox class="tbx" ID="tbxBirthday" TextMode="Date" runat="server" Text='<%# Eval("Birthday") %>' Visible="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>' />
                            <asp:TextBox class="tbx" ID="tbxPhone" TextMode="Phone" runat="server" Text='<%# Eval("Phone") %>' Visible="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                            <asp:TextBox class="tbx" ID="tbxEmail" TextMode="Email" runat="server" Text='<%# Eval("Email") %>' Visible="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblintRank" runat="server" Text='<%# Eval("Rank") %>' Visible="False" />
                            <asp:Label ID="lblRank" runat="server" Text='<%# Eval("Rank") %>' />
                            <asp:TextBox class="tbx" ID="tbxRank" min="0" max="5" TextMode="Number" runat="server" Text='<%# Eval("Rank") %>' Visible="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ID="btnCheck" runat="server" ImageUrl="~/Image/Checked.png" Width="1.5em" Visible="False" OnClick="btnCheck_Click"></asp:ImageButton>
                            <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/Image/Edit.png" Width="1.5em" Visible="False" OnClick="btnEdit_Click"></asp:ImageButton>
                            <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/Image/Cancel.png" Width="1.5em" Visible="False" OnClick="btnCancel_Click"></asp:ImageButton>
                            <asp:ImageButton ID="btnAdd" runat="server" ImageUrl="~/Image/Add.png" Width="1.5em" Visible="False" OnClick="btnAdd_Click"></asp:ImageButton>
                            <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/Image/UserDelete.png" Width="1.5em" Visible="False" OnClick="btnDelete_Click"></asp:ImageButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" style="width: 100%;">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" border="0" style="width: 100%;">
                                    <tr runat="server" style="width: 100%;">
                                        <th style="width: 15%;" runat="server">帳號</th>
                                        <th style="width: 15%;" runat="server">密碼</th>
                                        <th style="width: 8%;" runat="server">姓名</th>
                                        <th style="width: 12%;" runat="server">生日</th>
                                        <th style="width: 12%;" runat="server">電話</th>
                                        <th style="width: 22%;" runat="server">信箱</th>
                                        <th style="width: 8%;" runat="server">階級</th>
                                        <th style="width: 8%;" runat="server">動作</th>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="background-color: #3d3d3d; height: 0.5em;"></td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
            </ContentTemplate>
        </asp:UpdatePanel>
            <br />
        </div>
    </div>
    </center>
    </div>
    </form>
</body>
</html>
