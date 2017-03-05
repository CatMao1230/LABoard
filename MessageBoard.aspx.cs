using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MessageBoard : System.Web.UI.Page
{
    Boolean isLogin = false;
    String Name;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(int.Parse(Session["Rank"].ToString()) == 0){
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
                lblName.Text = Name;
                imgPicture.ImageUrl = "Image/" + Session["Account"].ToString() + ".jpg";
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

    protected void lvMessage_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Label lblName = (Label)e.Item.FindControl("lblName");
            Label lblDatetime = (Label)e.Item.FindControl("lblDatetime");
            Image imgPic = (Image)e.Item.FindControl("imgPic");
            ImageButton btnDelete = (ImageButton)e.Item.FindControl("btnDelete");

            String strSQL = @"SELECT * FROM [User] WHERE Account = @eAccount";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = lblName.Text;
            SqlDataReader data = cmd.ExecuteReader();

            while (data.Read()) //讀取結果
            {
                imgPic.ImageUrl = "Image/" + data["Account"].ToString() + ".jpg";
                lblName.Text = data["Name"].ToString();
                if (Session["Account"].ToString() == data["Account"].ToString()) // 刪除按鈕顯示
                {
                    btnDelete.Visible = true;
                }
            }
        }

        conn.Close();

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"INSERT INTO [MessageBoard] ([Account], [Datetime], [Message]) " + 
                        "VALUES ( @eAccount, @eDatetime, @eMessage )";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = Session["Account"].ToString();
        cmd.Parameters.Add("@eDatetime", SqlDbType.NVarChar).Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        cmd.Parameters.Add("@eMessage", SqlDbType.NVarChar).Value = tbxMessage.Text;
        SqlDataReader dataUser = cmd.ExecuteReader();
        tbxMessage.Text = "";

        conn.Close();
        lvMessage.DataBind();

    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        ImageButton btnDelete = (ImageButton)sender;
        String strID = ((Label)btnDelete.Parent.FindControl("lblID")).Text;

        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"DELETE [MessageBoard] WHERE [id] = @eID";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eID", SqlDbType.NVarChar).Value = strID;
        SqlDataReader dataUser = cmd.ExecuteReader();

        conn.Close();
        lvMessage.DataBind();
    }

}