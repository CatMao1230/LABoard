<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FoodList.aspx.cs" Inherits="FoodList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
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
        #divFL{
            width: 50%;
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

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        th{
            background-color: #FF2040;
            color: #ffffff;
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
    <div id="divAll">
    <center>
    <div id="divHead">
        <ul>
            <li><asp:HyperLink ID="aMessageBoard" runat="server" NavigateUrl="MessageBoard.aspx">留言板</asp:HyperLink></li>
            <li><asp:HyperLink ID="aBookMeal" class="active" runat="server" NavigateUrl="BookMeal.aspx">餐點</asp:HyperLink></li>
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
        <div id="divFL">
        <asp:Label ID="Label1" runat="server" Font-Size="XX-Large" Text="餐點清單"></asp:Label>
        <br /><br />
            <asp:HyperLink ID="aFoodMenu" runat="server" NavigateUrl="FoodMenu.aspx">菜單</asp:HyperLink> | 
            <asp:HyperLink ID="aBookMeal2" runat="server" NavigateUrl="BookMeal.aspx">訂餐</asp:HyperLink> | 
            <asp:HyperLink ID="aFoodList" runat="server" NavigateUrl="FoodList.aspx">餐點清單</asp:HyperLink>
        <br />
        <br />
        <br />
        <asp:Button ID="btndelall" style="float: right;" class="btnBlack" runat="server" Text="清空全部" OnClick="btndelall_Click"/>
            <br />
            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="Expr2" OnItemDataBound="ListView1_ItemDataBound1">
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>無訂餐紀錄</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr style="text-align: center;">
                        <td>
                            <asp:ImageButton ID="btnCoin" runat="server" OnClick="btnCoin_Click" ImageUrl="~/Image/Coin.png" Width="1em" Visible="False" Enabled="False"></asp:ImageButton>
                            <asp:ImageButton ID="btnCoinX" runat="server" OnClick="btnCoinX_Click" ImageUrl="~/Image/CoinX.png" Width="1em" Visible="False" Enabled="False"></asp:ImageButton>
               
                            <asp:Label ID="lblIsPaid" runat="server" Visible="false" Text='<%# Eval("isPaid") %>' />
                        </td>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                            <asp:Label ID="lblAccount" runat="server" Visible="false" Text='<%# Eval("Account") %>' />
                        </td>
                        <td>
                            <asp:Label ID="itemLabel" runat="server" Text='<%# Eval("item") %>' />
                        </td>
                        <td>
                            <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%# Eval("id") %>' />
                            
                            <asp:ImageButton ID="btndelete" runat="server" OnClick="btndelete_Onclick" ImageUrl="~/Image/Delete.png" Width="1em" Visible="False"></asp:ImageButton>
                        </td>
                        <td>
                            <asp:Label ID="idlable" runat="server" Text='<%# Eval("Expr2") %>' visible="false"/>
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" style="width: 100%;">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" style="width: 100%;">
                                    <tr runat="server" style="width: 100%;">
                                        <th style="width: 20%;" runat="server">付款狀態</th>
                                        <th style="width: 20%;" runat="server">姓名</th>
                                        <th style="width: 30%;" runat="server">項目</th>
                                        <th style="width: 20%;" runat="server">價格</th>
                                        <th style="width: 10%;" runat="server">刪除</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="background-color: #3d3d3d;; height: 0.5em;"></td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT Booklist.Account, Booklist.isPaid, Booklist.FoodID, Food.ID, Food.item, Food.price, [User].Name, [User].Account AS Expr1, Booklist.id AS Expr2 FROM Booklist INNER JOIN Food ON Booklist.FoodID = Food.ID INNER JOIN [User] ON Booklist.Account = [User].Account"></asp:SqlDataSource>
            <br />
        </div>
    </div>
    </center>
    </div>
    </form>
</body>
</html>
