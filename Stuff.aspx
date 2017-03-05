<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Stuff.aspx.cs" Inherits="ItemList" %>

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
        #divMB{
            width: 100%;
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
    <div id="divAll">
    <center>
    <div id="divHead">
        <ul>
            <li><asp:HyperLink ID="aMessageBoard" runat="server" NavigateUrl="MessageBoard.aspx">留言板</asp:HyperLink></li>
            <li><asp:HyperLink ID="aBookMeal" runat="server" NavigateUrl="BookMeal.aspx">餐點</asp:HyperLink></li>
            <li><asp:HyperLink ID="aFund" runat="server" NavigateUrl="Fund.aspx">記帳</asp:HyperLink></li>
            <li><asp:HyperLink ID="aToDoList" runat="server" NavigateUrl="ToDoList.aspx">待辦事項</asp:HyperLink></li>
            <li><asp:HyperLink ID="aDirectory" runat="server" NavigateUrl="Directory.aspx">通訊錄</asp:HyperLink></li>
            <li><asp:HyperLink ID="aStuff" class="active" runat="server" NavigateUrl="Stuff.aspx">物品清單</asp:HyperLink></li>
            <li><asp:HyperLink ID="aManager" runat="server" NavigateUrl="Manager.aspx" Visible="False">帳號管理</asp:HyperLink></li>
            <li style="float:right; padding: 14px 16px;"><asp:ImageButton ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" ImageUrl="~/Image/LogOut.png" Width="2em" /></li>
            <li style="float:right;"><asp:HyperLink ID="lblAccount" runat="server" NavigateUrl="User.aspx"></asp:HyperLink></li>
            <li style="float:right; padding: 10px 0px;"><asp:Image ID="imgUser" runat="server" ImageUrl="~/Image/Guest.png" style="width: 2em; height: 2em;border-radius: 1em;-webkit-border-radius: 1em;-moz-border-radius: 1em;"></asp:Image></li>
        </ul>
    </div>
    <div id="divMain">
        <div id="divMB">
        <asp:SqlDataSource ID="SDSItem" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [ItemList]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDSStatus" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [Item_Status] WHERE ([ItemID] = @ItemID)"
            UpdateCommand="UPDATE [LABoard].[dbo].[Item_Status]  SET [Name] =@name ,[Status] =@status  WHERE ([ID]  = @id)  "
            DeleteCommand="DELETE FROM [LABoard].[dbo].[Item_Status]  WHERE [ID] =@id  ">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="ItemID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>

        </asp:SqlDataSource>
        <asp:Label ID="lblTitle" runat="server" Font-Size="XX-Large" Text="物品清單"></asp:Label>
        <br />
        <br />
            <br />
        新增項目：<asp:TextBox ID="tbxAddItem" runat="server"></asp:TextBox>
        　<asp:Button ID="btnAddItem" runat="server" OnClick="btnAddItem_Click" Text="新增" />
        <br />
        <br />
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SDSItem" OnItemCommand="ListView1_ItemCommand">
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
                        <asp:Label ID="Label2" Visible="false" runat="server" Text='<%# Eval("ID") %>' />
                        <asp:Label ID="lblGood" runat="server" Text='<%# Eval("Item") %>' />
                    </td>
                    <td>
                        <asp:Button ID="btnDetails" runat="server" Text="詳細資料" BackColor="lightpink" Width="80px" OnClick="btnDetails_Click"
                            CommandArgument='<%# Eval("ID") %>'></asp:Button>  
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server"  style="width:35%; background-color:seashell; ">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="0" style="width:100%; text-align:center;">
                                <tr runat="server" style="background-color:indianred;color:white;">
                                    <th runat="server">項目</th>
                                    <th runat="server"></th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style=""></td>
                    </tr>
                </table>
            </LayoutTemplate>

        </asp:ListView>

        <br />
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SDSItem" DataTextField="Item" DataValueField="ID" Enabled="False" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        </asp:DropDownList>

        <br />
        項目：&nbsp;<asp:DropDownList ID="ddlItem" runat="server" DataSourceID="SDSItem" DataTextField="Item" DataValueField="ID">
        </asp:DropDownList>
        名稱：<asp:TextBox ID="tbxNewName" runat="server" Width="169px"></asp:TextBox>
&nbsp;<asp:Button ID="btnAdd" runat="server" OnClick="btnAdd_Click" Text="新增物品" />

        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SDSStatus"
             ForeColor="#333333" GridLines="None" Width="650px" style="margin-right: 0px" Visible="false"
            DataKeyNames="ID" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting"
             OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound">
            <AlternatingRowStyle BackColor="White" />
            <Columns>                  
                    <asp:TemplateField HeaderText="編號" visible="false">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%#Bind("ID") %>'></asp:Label>
                            </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="物品編號" >
                            <ItemTemplate>
                                <asp:Label ID="lblitem" runat="server" Text='<%#Bind("ItemID") %>'></asp:Label>
                            </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="物品名稱">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxname" runat="server" Text='<%#Bind("Name") %>'></asp:TextBox>
                            </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="狀態" >
                            <ItemTemplate>
                                <asp:Label ID="lblstatus" runat="server" Text='<%#Bind("Status") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tbxstatus" runat="server" Text='<%#Bind("Status") %>'></asp:TextBox>
                            </EditItemTemplate>
                    </asp:TemplateField>                     
                    <asp:TemplateField>
                        <EditItemTemplate>
                            <asp:Button ID="update_btn" runat="server" Text="更新" CommandName="Update" />
                            <asp:Button ID="cancel_btn" runat="server" Text="取消" CommandName="Cancel" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="edit_btn" runat="server" Text="編輯" CommandName="Edit" />
                            <asp:Button ID="delete_btn" runat="server" Text="刪除" CommandName="Delete" OnClientClick="return confirm('確定刪除?');" />                               
                        </ItemTemplate>
                    </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#B22222" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"/>
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" HorizontalAlign="Center"/>
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>

        <br />

        </div>
    </div>
    </center>
    </div>
    </form>
</body>
</html>
