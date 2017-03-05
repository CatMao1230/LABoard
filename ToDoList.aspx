<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ToDoList.aspx.cs" Inherits="_Default" %>

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
        #divToDo{
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

        #divBody{
            position: absolute;
            padding: 1%;
            top: 10%;
            left: 38%;
            width: 30%;
            background-color: #FCFCFC;
            text-align: left;
        }
       
         #FinishedBtn{
               border-radius:12px;
               padding: 8px 4px;
               background-color:grey;
               Color:white;
               
        }
         #EditBtn{
               border-radius:12px;
               padding: 8px 4px;
               background-color:grey;
               Color:white;
               
        }
         #AddBtn{
            
               border-radius:12px;
               padding: 8px 4px;
               background-color:grey;
               Color:white;
               
           }
        #nfBtn{
               border-radius:8px;
        }
         #fBtn{
               border-radius:8px;
        }
        table.MsoTableGrid{
            border:solid windowtext 1.0pt;
	        font-size:12.0pt;
	        font-family:"Calibri",sans-serif;
	    }
        p.MsoNormal{
            margin-bottom:.0001pt;
	        font-size:12.0pt;
	        font-family:"Calibri",sans-serif;
	                margin-left: 0cm;
                    margin-right: 0cm;
                    margin-top: 0cm;
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
            <li><asp:HyperLink ID="aToDoList" class="active" runat="server" NavigateUrl="ToDoList.aspx">待辦事項</asp:HyperLink></li>
            <li><asp:HyperLink ID="aDirectory" runat="server" NavigateUrl="Directory.aspx">通訊錄</asp:HyperLink></li>
            <li><asp:HyperLink ID="aStuff" runat="server" NavigateUrl="Stuff.aspx">物品清單</asp:HyperLink></li>
            <li><asp:HyperLink ID="aManager" runat="server" NavigateUrl="Manager.aspx" Visible="False">帳號管理</asp:HyperLink></li>
            <li style="float:right; padding: 14px 16px;"><asp:ImageButton ID="btnLogOut" runat="server" OnClick="btnLogOut_Click" ImageUrl="~/Image/LogOut.png" Width="2em" /></li>
            <li style="float:right;"><asp:HyperLink ID="lblAccount" runat="server" NavigateUrl="User.aspx"></asp:HyperLink></li>
            <li style="float:right; padding: 10px 0px;"><asp:Image ID="imgUser" runat="server" ImageUrl="~/Image/Guest.png" style="width: 2em; height: 2em;border-radius: 1em;-webkit-border-radius: 1em;-moz-border-radius: 1em;"></asp:Image></li>
        </ul>
    </div>
    <div id="divMain">
       <div id="divToDo">
     <center>
        <asp:Label ID="Label7" runat="server" Font-Size="xx-large" Text="待辦事項"></asp:Label>
     </center>
        <br />
        <br />
        <br />
        <asp:Button ID="nfBtn"  runat="server"  OnClick="Button1_Click" Text="待完成" Height="30px" Width="66px" />
        <asp:Button ID="fBtn" runat="server"  Text="已完成" OnClick="Button2_Click" Height="30px" Width="66px" />
        <br />
          <br />
          <br />
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <asp:TextBox ID="Inputtxb" runat="server" Font-Names="monospace" OnTextChanged="TextBox1_TextChanged" Height="68px" Width="295px"></asp:TextBox>
                <asp:Button ID="AddBtn" runat="server" Text="add" Font-Names="monospace" Font-Size="0.8em"  Width="72px" OnClick="AddBtn_Click1" />
           
        <br />
               
                <br />
                <asp:CheckBoxList ID="Contentcbl" runat="server" DataSourceID="SqlDataSource1" DataTextField="Content" DataValueField="id" Font-Bold="True" Font-Names="Agency FB,Microsoft JhengHei" Font-Size="1.5em" OnDataBound="CheckBoxList1_SelectedIndexChanged" OnSelectedIndexChanged="CheckBoxList1_SelectedIndexChanged">
                    <asp:ListItem></asp:ListItem>
                </asp:CheckBoxList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [ToDoList] WHERE ([Finished] = @Finished)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="false" Name="Finished" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <br />
                <br />
                <asp:Button ID="FinishedBtn" runat="server" Text="finished" Font-Names="monospace" Font-Size="0.8em" OnClick="FinishedBtn_Click" Width="72px" />
                <asp:Button ID="EditBtn" runat="server" Font-Names="monospace,Microsoft JhengHei" Font-Size="0.8em" Text="編 輯" Width="72px" OnClick="EditBtn_Click" style="margin-top: 0px;" Height="34px" Visible="False" />
        </asp:View>
            <asp:View ID="View2" runat="server">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LABoardConnectionString %>" SelectCommand="SELECT * FROM [ToDoList] WHERE ([Finished] = @Finished)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="true" Name="Finished" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <br />
                <center>
                <asp:DataList ID="DataList1" runat="server" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333"   Font-Bold="True" Font-Italic="True" Font-Names="monospace,Microsoft JhengHei" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center">
                    <AlternatingItemStyle BackColor="White" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="#666666" />
                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                    <ItemStyle BackColor="#CC0000" Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="White" />
                    <ItemTemplate>
                        &nbsp;<asp:Label ID="ContentLabel" runat="server" Text='<%# Eval("Content") %>' />
                        <br />
                        <br />
                    </ItemTemplate>
                    <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                </asp:DataList>
                    </center>
            </asp:View>
        </asp:MultiView>
         <br />
        <br />
     
        &nbsp;<br />
        <br />
        <br />
     
    </div>
     </div>
    </center>
    </div>
    </form>
</body>
</html>