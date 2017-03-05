<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fund.aspx.cs" Inherits="Fund" %>

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
<body>
    <center>
        <form id="form1" runat="server">
            <div id="divAll">
            <center>
            <div id="divHead">
                <ul>
                    <li><asp:HyperLink ID="aMessageBoard" runat="server" NavigateUrl="MessageBoard.aspx">留言板</asp:HyperLink></li>
                    <li><asp:HyperLink ID="aBookMeal" runat="server" NavigateUrl="BookMeal.aspx">餐點</asp:HyperLink></li>
                    <li><asp:HyperLink ID="aFund" class="active" runat="server" NavigateUrl="Fund.aspx">記帳</asp:HyperLink></li>
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [Fund_Month]">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [FundList] WHERE ([Month] = @Month )"
                UpdateCommand="UPDATE [LABoard].[dbo].[FundList] SET [Year] =@year ,[Month] =@month ,[Day] =@day , [Item] =@item,[Category] =@category ,[Price] =@price   WHERE ([ID] =@id)  " 
                DeleteCommand="DELETE FROM [LABoard].[dbo].[FundList]  WHERE ([ID] =@id)  ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="Month" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [Fund_Category]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [User]"></asp:SqlDataSource>
            <asp:Label ID="lblTitle" runat="server" Font-Size="XX-Large" Text="記帳"></asp:Label>
            <br />
            <br /><br />
            <asp:Label ID="lblTotal" runat="server" Font-Bold="True" Font-Size="Large" Text="公費總額："></asp:Label>
            <asp:Label ID="lblTotalmoney" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="#006699"></asp:Label>
            <br />
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True" DataSourceID="SqlDataSource1" 
                DataTextField="Month" DataValueField="monthID" DataTextFormatString="{0:d}">
                <asp:ListItem Value="9">9月</asp:ListItem>
                <asp:ListItem Value="10">10月</asp:ListItem>
                <asp:ListItem Value="11">11月</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
                <table style="text-align:center;width:719px;">
                    <tr>
                        <td>年</td>
                        <td>月</td>
                        <td>日</td>
                        <td>填寫人</td>
                        <td>類別</td>
                        <td>項目</td>
                        <td>金額</td>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="tbxYear" runat="server" Width="55px"></asp:TextBox></td>
                        <td><asp:TextBox ID="tbxMonth" runat="server" Width="30px"></asp:TextBox></td>
                        <td><asp:TextBox ID="tbxDay" runat="server" Width="32px"></asp:TextBox></td>
                        <td><asp:TextBox ID="tbxName" runat="server" Width="73px" ForeColor="#0000CC" ReadOnly="True"></asp:TextBox></td>
                        <td><asp:DropDownList ID="DDLCategory" runat="server" DataSourceID="SqlDataSource3" DataTextField="Category" DataValueField="Category">
                            </asp:DropDownList></td>
                        <td><asp:TextBox ID="tbxItem" runat="server" Width="128px"></asp:TextBox></td>
                        <td><asp:TextBox ID="tbxMoney" runat="server" Width="128px"></asp:TextBox></td>
                    </tr>

                </table>
          
    &nbsp;<asp:Button ID="btnInsert" runat="server" Text="新增帳目" Width="114px" OnClick="btnInsert_Click" />
            <br />
            <br />
                <asp:GridView ID="GridView2" runat="server" 
                    AutoGenerateColumns="False" CellPadding="4"  ForeColor="#333333"  DataSourceID="SqlDataSource2"
                     GridLines="None" OnRowDataBound="GridView2_RowDataBound" ShowFooter="True" Width="800px" 
                    style="margin-right: 0px" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating"
                     OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowDeleting="GridView2_RowDeleting" DataKeyNames="ID" >
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText=" " Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblid" runat="server" Text='<%#Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                               
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="年">
                                <ItemTemplate>
                                    <asp:Label ID="lbly" runat="server" Text='<%#Bind("Year") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxy" runat="server" Text='<%#Bind("Year") %>'></asp:TextBox>
                                </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="月">
                                <ItemTemplate>
                                    <asp:Label ID="lblm" runat="server" Text='<%#Bind("Month") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxm" runat="server" Text='<%#Bind("Month") %>'></asp:TextBox>
                                </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="日">
                                <ItemTemplate>
                                    <asp:Label ID="lbld" runat="server" Text='<%#Bind("Day") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxd" runat="server" Text='<%#Bind("Day") %>'></asp:TextBox>
                                </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="填寫人">
                                <ItemTemplate>
                                    <asp:Label ID="lblu" runat="server" Text='<%#Bind("UserName") %>'></asp:Label>
                                </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="類別">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlc" runat="server" SelectedValue='<%#Bind("Category") %>'>
                                        <asp:ListItem Value="繳交">繳交</asp:ListItem>
                                        <asp:ListItem Value="文書費用">文書費用</asp:ListItem>
                                        <asp:ListItem Value="課內器材費">課內器材費</asp:ListItem>
                                        <asp:ListItem Value="獎金、補助">獎金、補助</asp:ListItem>
                                        <asp:ListItem Value="交通費">交通費</asp:ListItem>
                                        <asp:ListItem Value="食物費">食物費</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlc" runat="server" Enabled="false" SelectedValue='<%#Bind("Category") %>'>
                                        <asp:ListItem Value="繳交">繳交</asp:ListItem>
                                        <asp:ListItem Value="文書費用">文書費用</asp:ListItem>
                                        <asp:ListItem Value="課內器材費">課內器材費</asp:ListItem>
                                        <asp:ListItem Value="獎金、補助">獎金、補助</asp:ListItem>
                                        <asp:ListItem Value="交通費">交通費</asp:ListItem>
                                        <asp:ListItem Value="食物費">食物費</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="項目">
                                <ItemTemplate>
                                    <asp:Label ID="lbli" runat="server" Text='<%#Bind("Item") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxi" runat="server" Text='<%#Bind("Item") %>'></asp:TextBox>
                                </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="金額">
                                <ItemTemplate>
                                    <asp:Label ID="lblp" runat="server" Text='<%#Bind("Price") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxp" runat="server" Text='<%#Bind("Price") %>'></asp:TextBox>
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
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#993333" Font-Bold="True" ForeColor="White" BorderColor="#CC0000" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#336699" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" HorizontalAlign="Center" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
              
                
                <br />
                <br />
            </div>
        </div>
        </center>
        </div>

        </form>
    </center>
</body>
</html>
