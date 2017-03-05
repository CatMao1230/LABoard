using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class ItemList : System.Web.UI.Page
{

    Boolean isLogin = false;
    String Name;
    private DataSet getData()
    {
        String connectString = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection cn = new SqlConnection(connectString);
        String selectString = "SELECT * FROM [LABoard].[dbo].[Itemd_Status]";
        SqlCommand cmd = new SqlCommand(selectString, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        cn.Open();
        da.Fill(ds);
        cn.Close();
        return ds;
    }
    private void GVgetData()
    {
        GridView1.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (int.Parse(Session["Rank"].ToString()) == 0)
        {
            Response.Redirect("Login.aspx");
        }
        if (Session["Account"] != null)
        {
            isLogin = true;
            SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
            conn.Open();
            String strSQL = @"SELECT * FROM [User] WHERE Account = @eAccount";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = Session["Account"].ToString();
            SqlDataReader dataUser = cmd.ExecuteReader();

            while (dataUser.Read()) //讀取結果
            {
                Name = dataUser["Name"].ToString();
                lblAccount.Text = Name;
                imgUser.ImageUrl = "Image/" + Session["Account"].ToString() + ".jpg";

                if ((int)dataUser["Rank"] == 5)
                {
                    aManager.Visible = true;
                }
            }

            conn.Close();
        }
        else // 非法登入
        {
            isLogin = false;
            Response.Redirect("Login.aspx");
        }
    }

    protected void btnLogOut_Click(object sender, EventArgs e)
    {
        if (isLogin) //登出
        {
            lblAccount.Text = "尚未登入";
            Session.Remove("Account");
            Response.Redirect("Login.aspx");
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void btnDetails_Click(object sender, EventArgs e)
    {
      //  Response.Redirect("~/ItemDetails.aspx");  //煥頁

        Button btnDetails = (Button)sender;
        Label lblID = (Label)btnDetails.Parent.FindControl("lblID");
        Label lblGood = (Label)btnDetails.Parent.FindControl("lblGood");
        string selectid = btnDetails.CommandArgument.ToString();
        string zWhere = "SELECT *  FROM [LABoard].[dbo].[Item_Status] " + "WHERE ([ItemID] = @itemid )";
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection cn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zWhere, cn);
        cmd.Parameters.Add("@itemid", SqlDbType.Int).Value = selectid;
        cn.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if(dr.Read())
        {
            // GridView1.Columns[int.Parse(selectid)].Visible = true;
            GridView1.DataBind();
        }
        DropDownList1.SelectedValue = selectid;
        GridView1.Visible = true;
        GridView1.DataBind();
        dr.Close();
        cn.Close();

        ddlItem.SelectedValue = selectid;
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        GVgetData();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        GVgetData();
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //編輯更新資料庫
        string zUpdateByID = "UPDATE [LABoard].[dbo].[Item_Status] " + "SET [Name] =@name ,[Status] =@status " +
        "WHERE ([ID]  = @id)  ";
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection cn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zUpdateByID, cn);
        cmd.Parameters.Add("@id", SqlDbType.Int).Value = GridView1.Rows[e.RowIndex].Cells[0].Text;
        cmd.Parameters.Add("@name", SqlDbType.NVarChar).Value = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("tbxname")).Text;
        cmd.Parameters.Add("@status", SqlDbType.NVarChar).Value = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("tbxstatus")).Text;
        
        cn.Open();
        cn.Close();
        GridView1.EditIndex = -1;
        GVgetData();
        GridView1.DataBind();
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //刪除資料
        string zDeleteByID = "DELETE FROM [LABoard].[dbo].[Item_Status]  WHERE [ID] =@id  ";
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection cn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zDeleteByID, cn);
        cmd.Parameters.Add("@id", SqlDbType.Int);
        cmd.Parameters["@id"].Value = GridView1.Rows[e.RowIndex].Cells[0].Text;
        cn.Open();
        //      cmd.ExecuteNonQuery();
        cn.Close();
        GVgetData();
        GridView1.DataBind();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void BtnInsertItem_Click(object sender, EventArgs e)
    {
        //新增資料
        string zInsertByID = "INSERT INTO [LABoard].[dbo].[ItemList] "
            + "([Item] )" +
            "VALUES (@item)";
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zInsertByID, conn);
        string zInsertByID2 = "INSERT INTO [LABoard].[dbo].[Item_Status] " + "([ItemID] ,[Name] )" +
           "VALUES (@itemid ,@name )";
        string connStr2 = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn2 = new SqlConnection(connStr2);
        SqlCommand cmd2 = new SqlCommand(zInsertByID2, conn2);


        //缺少抓取是否輸入相同物品
        cmd2.Parameters.Add("@name", SqlDbType.NVarChar).Value = tbxNewName.Text;
        //cmd2.Parameters.Add("@itemid",SqlDbType.Int).Value = 
        conn.Open();
        conn2.Open();
        int rows = cmd.ExecuteNonQuery();
        conn2.Close();
        conn.Close();
        ListView1.DataBind();
        GridView1.DataBind();
        
        tbxNewName.Text = "";
    }

    protected void btnAddItem_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"INSERT INTO [ItemList] ( [Item] ) VALUES ( @eItem )";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eItem", SqlDbType.NVarChar).Value = tbxAddItem.Text;
        SqlDataReader dataUser = cmd.ExecuteReader();

        conn.Close();
        ListView1.DataBind();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"INSERT INTO [Item_Status] ( [ItemID], [Name] ) VALUES ( @eItem, @eName )";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eItem", SqlDbType.Int).Value = ddlItem.SelectedValue;
        cmd.Parameters.Add("@eName", SqlDbType.NVarChar).Value = tbxNewName.Text;
        SqlDataReader data = cmd.ExecuteReader();

        conn.Close();
        GridView1.DataBind();
    }
}