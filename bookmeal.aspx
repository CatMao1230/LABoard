<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookMeal.aspx.cs" Inherits="bookmeal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
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
        #divBM{
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

        .btnRed{
            background-color: #FF2040;
            border-color: #FF2040;
            border-width: 2px;
            border-style: solid;
            border-radius: 5px;
            height: 30px;
            color: #FFFFFF;
        }

        .tableBM tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .tableBM th{
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
        <div id="divBM">
        <asp:Label ID="Label6" runat="server" Font-Size="XX-Large" Text="訂餐"></asp:Label>
        <br /><br />
            <asp:HyperLink ID="aFoodMenu" runat="server" NavigateUrl="FoodMenu.aspx">菜單</asp:HyperLink> | 
            <asp:HyperLink ID="aBookMeal2" runat="server" NavigateUrl="BookMeal.aspx">訂餐</asp:HyperLink> | 
            <asp:HyperLink ID="aFoodList" runat="server" NavigateUrl="FoodList.aspx">餐點清單</asp:HyperLink>
        <br />
        <br />
        <br />
        <asp:Label ID="Label1" runat="server" Text="今日餐廳："></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="id" Enabled="False" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        </asp:DropDownList>
        <br /><br />


        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [Store]"></asp:SqlDataSource>

                    <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource2" AutoPostBack="True" OnItemDataBound="ListView1_ItemDataBound">
                        <EmptyDataTemplate>
                            <table runat="server" style="">
                                <tr>
                                    <td>未傳回資料。</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label ID="itemLabel" runat="server" Text='<%# Eval("item") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="idLabel" runat="server" Text='<%# Eval("id") %>' Visible="False" />
                                    <asp:CheckBox ID="cbxCheck" runat="server" AutoPostBack="True" OnCheckedChanged="cbxCheck_CheckedChanged" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" class="tableBM" style="width: 100%; text-align: center;">
                                <tr runat="server">
                                    <td runat="server">
                                        <table id="itemPlaceholderContainer" runat="server" border="0" style="width: 100%;">
                                            <tr runat="server" style="width: 100%;">
                                                <th style="width: 40%;" runat="server">餐點</th>
                                                <th style="width: 30%;" runat="server">價格</th>
                                                <th style="width: 30%;" runat="server">勾選</th>
                                            </tr>
                                            <tr id="itemPlaceholder" runat="server">
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
                    <br />
                    <asp:Label ID="Label7" runat="server" Text="*請勾取點餐"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="lblMeal" runat="server"></asp:Label>     
                        <br />
                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                     <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [Food] WHERE ([StoreID] = @StoreID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="StoreID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>   
<asp:Button ID="Button2" class="btnBlack" runat="server" Text="重新修改" OnClick="Button2_Click" />
　<asp:Button ID="Button1" class="btnRed" runat="server" Text="確認訂餐" OnClick="Button1_Click" />
        <br />

        </div>
    </div>
    </center>
    </div>
    </form>
</body>
</html>
