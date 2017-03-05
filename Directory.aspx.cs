using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class FoodList : System.Web.UI.Page
{
    string zInsertByID = "INSERT INTO [LABoard].[dbo].[Directory1] "
       + "([name] ,[number] ,[email] )" +
       "VALUES (@name ,@number ,@email )" +
       "SELECT scope_identity() ";
    Boolean isLogin = false;
    String Name;
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

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        //  string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";

        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand(zInsertByID, conn);

        cmd.Parameters.Add("@name", SqlDbType.NVarChar).Value = tbxName.Text;
        cmd.Parameters.Add("@number", SqlDbType.NVarChar).Value = tbxNumber.Text;
        cmd.Parameters.Add("@email", SqlDbType.NVarChar).Value = tbxemail.Text;

        conn.Open();
        int rows = cmd.ExecuteNonQuery();
        conn.Close();
        GridView1.DataBind();

        tbxName.Text = "";
        tbxNumber.Text = "";
        tbxemail.Text = "";
    }
}