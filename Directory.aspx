<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Directory.aspx.cs" Inherits="FoodList" %>

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
        #divMB{
            width: 70%;
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
<body style="text-align: left">
    <form id="form1" runat="server">
    <div id="divAll">
    <center>
    <div id="divHead">
        <ul>
            <li><asp:HyperLink ID="aMessageBoard" runat="server" NavigateUrl="MessageBoard.aspx">留言板</asp:HyperLink></li>
            <li><asp:HyperLink ID="aBookMeal" runat="server" NavigateUrl="BookMeal.aspx">餐點</asp:HyperLink></li>
            <li><asp:HyperLink ID="aFund" runat="server" NavigateUrl="Fund.aspx">記帳</asp:HyperLink></li>
            <li><asp:HyperLink ID="aToDoList" runat="server" NavigateUrl="ToDoList.aspx">待辦事項</asp:HyperLink></li>
            <li><asp:HyperLink ID="aDirectory" class="active" runat="server" NavigateUrl="Directory.aspx">通訊錄</asp:HyperLink></li>
            <li><asp:HyperLink ID="aStuff" runat="server" NavigateUrl="Stuff.aspx">物品清單</asp:HyperLink></li>
            <li><asp:HyperLink ID="aManager" runat="server" NavigateUrl="Manager.aspx" Visible="False">帳號管理</asp:HyperLink></li>
            <li style="float:right; padding: 14px 16px;"><asp:ImageButton ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" ImageUrl="~/Image/LogOut.png" Width="2em" /></li>
            <li style="float:right;"><asp:HyperLink ID="lblAccount" runat="server" NavigateUrl="User.aspx"></asp:HyperLink></li>
            <li style="float:right; padding: 10px 0px;"><asp:Image ID="imgUser" runat="server" ImageUrl="~/Image/Guest.png" style="width: 2em; height: 2em;border-radius: 1em;-webkit-border-radius: 1em;-moz-border-radius: 1em;"></asp:Image></li>
        </ul>
    </div>
    <div id="divMain">
        <div id="divMB">
    
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" 
            DeleteCommand="DELETE FROM [Directory1] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [Directory1] ([number], [email], [name]) VALUES (@number, @email, @name)" 
            SelectCommand="SELECT [id], [number], [email], [name] FROM [Directory1]" 
            UpdateCommand="UPDATE [Directory1] SET [number] = @number, [email] = @email, [name] = @name WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="number" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="name" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="number" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Font-Size="XX-Large" Text="通訊錄"></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="姓名："></asp:Label>
        <asp:TextBox ID="tbxName" runat="server" Width="90px"></asp:TextBox>
            &nbsp;&nbsp; 電話： <asp:TextBox ID="tbxNumber" runat="server" Width="130px"></asp:TextBox>
            &nbsp; email： <asp:TextBox ID="tbxemail" runat="server" Width="191px"></asp:TextBox>
        <asp:Button ID="btnInsert" runat="server" Text="新增人員" OnClick="btnInsert_Click"/>
        <br />
        <br />
    </div>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="id" 
            DataSourceID="SqlDataSource1" GridLines="Horizontal" ForeColor="Black" >
            <Columns>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" 
                    ShowEditButton="True" />
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id" Visible="False" />
                <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
                <asp:BoundField DataField="number" HeaderText="電話" SortExpression="number" />
                <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
            </div>
    </div>
    </center>
    </div>
    </form>
</body>
</html>
