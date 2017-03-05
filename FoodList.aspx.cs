using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FoodList : System.Web.UI.Page
{
    static int idvalue;

    Boolean isLogin = false;
    Boolean isCanEdit = false;
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
                if ((int)dataUser["Rank"] >= 4)
                {
                    isCanEdit = true;
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

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {

    }

    public void btndelete_Onclick(object sender, EventArgs e)
    {
        var btn = (ImageButton)sender;
        idvalue =int.Parse( ((Label)btn.Parent.FindControl("idlable")).Text);
        

        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);

        String strSQL = @"DELETE  FROM [Booklist] WHERE [id] =" + idvalue;
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("id", SqlDbType.Int).Value = 0;
        conn.Open();
        cmd.ExecuteReader();
        conn.Close();

        ListView1.DataBind();

    }

    protected void btndelall_Click(object sender, EventArgs e)
    {
        string connStr = "Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connStr);
       
        String strSQL = @"DELETE  FROM [Booklist] WHERE [Account]<>'0'";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("Account", SqlDbType.NVarChar).Value = 0;
        conn.Open();
        int rows = cmd.ExecuteNonQuery();
        conn.Close();

        ListView1.DataBind();
    }

    protected void ListView1_ItemDataBound1(object sender, ListViewItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");

        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Label lblAccount = (Label)e.Item.FindControl("lblAccount");
            Label lblID = (Label)e.Item.FindControl("idlable");
            Label lblIsPaid = (Label)e.Item.FindControl("lblIsPaid");
            ImageButton btndelete = (ImageButton)e.Item.FindControl("btndelete");
            ImageButton btnCoin = (ImageButton)e.Item.FindControl("btnCoin");
            ImageButton btnCoinX = (ImageButton)e.Item.FindControl("btnCoinX");

            conn.Open();
            String strSQL = @"SELECT * FROM [User] WHERE Account = @eAccount";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = lblAccount.Text;
            SqlDataReader data = cmd.ExecuteReader();
            
            while (data.Read()) //讀取結果
            {
                if (Session["Account"].ToString() == data["Account"].ToString()) // 刪除按鈕顯示
                {
                    btndelete.Visible = true;
                }
            }
            conn.Close();

            conn.Open();
            String strSQL2 = @"SELECT * FROM [Booklist] WHERE id = @eID";
            SqlCommand cmd2 = new SqlCommand(strSQL2, conn); //建立 SQL 命令對象
            cmd2.Parameters.Add("@eID", SqlDbType.Int).Value = int.Parse(lblID.Text);
            SqlDataReader data2 = cmd2.ExecuteReader();

            while (data2.Read()) //讀取結果
            {
                if (Boolean.Parse(data2["isPaid"].ToString())) // 已付錢
                {
                    btnCoin.Visible = true;
                }
                else
                {
                    btnCoinX.Visible = true;
                }
            }
            conn.Close();



            if (isCanEdit)
            {
                btndelete.Visible = true;
                btnCoinX.Enabled = true;
                btnCoin.Enabled = true;
            }

        }

    }
    

    protected void btnCoin_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton btnCoin = (ImageButton)sender;
        String strID = ((Label)btnCoin.Parent.FindControl("idlable")).Text;

        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"UPDATE [Booklist] SET [isPaid] = 0 WHERE [id] = @eID";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eID", SqlDbType.Int).Value = int.Parse(strID);
        SqlDataReader dataUser = cmd.ExecuteReader();

        conn.Close();
        ListView1.DataBind();
    }

    protected void btnCoinX_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton btnCoinX = (ImageButton)sender;
        String strID = ((Label)btnCoinX.Parent.FindControl("idlable")).Text;
        

        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"UPDATE [Booklist] SET [isPaid] = 1 WHERE [id] = @eID";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eID", SqlDbType.Int).Value = int.Parse(strID);
        SqlDataReader dataUser = cmd.ExecuteReader();

        conn.Close();
        ListView1.DataBind();
    }
}