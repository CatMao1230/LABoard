<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoodsList.aspx.cs" Inherits="GoodsList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [GoodsList]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDSItem" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [Goods_Item]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SDSRemarks" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [Goods_Records]"></asp:SqlDataSource>
        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="X-Large" Text="物品清單"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lblGoods" runat="server" Text="物品："></asp:Label>
        <asp:TextBox ID="tbxGoods" runat="server"></asp:TextBox>
        &nbsp;
        <asp:Label ID="lblnums" runat="server" Text="數量："></asp:Label>
        <asp:TextBox ID="tbxNums" runat="server" Width="118px"></asp:TextBox>
&nbsp;<asp:Label ID="lblRemarks" runat="server" Text="備註："></asp:Label>
        <asp:TextBox ID="tbxRemarks" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnInsert" runat="server" OnClick="btnInsert_Click" Text="新增物品" style="width: 102px" />
        <br />
        <br />
&nbsp;<asp:Button ID="btnEdit" runat="server" Text="編輯物品" />
        <br />

        <br />
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource1">

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
                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblGood" runat="server" Text='<%# Eval("Goods") %>' />
                        <asp:TextBox ID="tbxGood" runat="server"  Text='<%# Eval("Goods") %>' Visible="False"></asp:TextBox>                    
                    </td>
                    <td>
                        <asp:Label ID="lblNum" runat="server" Text='<%# Eval("Num") %>' />
                        <asp:TextBox ID="tbxNum" runat="server"  Text='<%# Eval("Num") %>' Visible="False"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remarks") %>' />
                        <asp:TextBox ID="tbxRemark" runat="server"  Text='<%# Eval("Remarks") %>' Visible="False"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnEdit" runat="server" Text="編輯" BackColor="gray" Width="65px" OnClick="btnEdit_Click"></asp:Button>
                        <asp:Button ID="btnAdd" runat="server" Text="確定" BackColor="gray" Width="65px"  Visible="False" OnClick ="btnAdd_Click"></asp:Button>                        
                    </td>
                </tr>
            </ItemTemplate>

            <LayoutTemplate>
                <table runat="server"  style="width:40%; background-color:gainsboro;">
                    <tr runat="server">
                        <td runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="0" style="width:100%; text-align:center;">
                                <tr runat="server" style="background-color:steelblue;color:white;">
                                    <th runat="server">編號</th>
                                    <th runat="server">物品名稱</th>
                                    <th runat="server">數量</th>
                                    <th runat="server">備註</th>
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
    </center>
    </div>
    </form>
</body>
</html>
