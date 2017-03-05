using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;

public partial class Manager : System.Web.UI.Page
{
    Boolean isLogin = false;
    String Name;
    String[] arrRank = { "待審核", "低階會員", "中階會員", "高階會員", "管理員", "站長" };
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
                imgUser.ImageUrl = "Image/" + Session["Account"].ToString() +".jpg";
                if ((int)dataUser["Rank"] == 5)
                {
                    aManager.Visible = true;
                    lblError.Visible = false;
                    lvAccount.Visible = true;
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

    protected void lvAccount_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();

        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Label lblAccount = (Label)e.Item.FindControl("lblAccount");
            Label lblBirthday = (Label)e.Item.FindControl("lblBirthday");
            Label lblRank = (Label)e.Item.FindControl("lblRank");
            TextBox tbxBirthday = (TextBox)e.Item.FindControl("tbxBirthday");
            ImageButton btnEdit = (ImageButton)e.Item.FindControl("btnEdit");
            ImageButton btnDelete = (ImageButton)e.Item.FindControl("btnDelete");
            ImageButton btnAdd = (ImageButton)e.Item.FindControl("btnAdd");

            String strSQL = @"SELECT * FROM [User] WHERE Account = @eAccount";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = lblAccount.Text;
            SqlDataReader data = cmd.ExecuteReader();
            while (data.Read())
            {
                DateTime dt = (DateTime)data["Birthday"];
                lblBirthday.Text = dt.ToString("yyyy/MM/dd");
                tbxBirthday.Text = dt.ToString("yyyy/MM/dd");

                lblRank.Text = arrRank[(int)data["Rank".ToString()]].ToString();
                if ((int)data["Rank"] == 0) // 待審核
                {
                    btnAdd.Visible = true;
                    btnDelete.Visible = true;
                }
                else
                {
                    btnEdit.Visible = true;
                }
            }
        }

        conn.Close();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ImageButton btnAdd = (ImageButton)sender;
        String lblAccount = ((Label)btnAdd.Parent.FindControl("lblAccount")).Text;
        String strID = ((Label)btnAdd.Parent.FindControl("lblID")).Text;

        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"UPDATE [User] SET [Rank] = 1 WHERE [Account] = @eAccount";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = lblAccount;
        SqlDataReader dataUser = cmd.ExecuteReader();

        conn.Close();
        lvAccount.DataBind();
    }
    protected void btnCheck_Click(object sender, EventArgs e)
    {
        ImageButton btnCheck = (ImageButton)sender;
        String strAccount = ((TextBox)btnCheck.Parent.FindControl("tbxAccount")).Text;
        String strName = ((TextBox)btnCheck.Parent.FindControl("tbxName")).Text;
        String strBirthday = ((TextBox)btnCheck.Parent.FindControl("tbxBirthday")).Text;
        String strPhone = ((TextBox)btnCheck.Parent.FindControl("tbxPhone")).Text;
        String strEmail = ((TextBox)btnCheck.Parent.FindControl("tbxEmail")).Text;
        String strRank = ((TextBox)btnCheck.Parent.FindControl("tbxRank")).Text;
        String lblAccount = ((Label)btnCheck.Parent.FindControl("lblAccount")).Text;
        String strID = ((Label)btnCheck.Parent.FindControl("lblID")).Text;

        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        SqlCommand cmd;

        if (((TextBox)btnCheck.Parent.FindControl("tbxPassword")).Text == "") // 密碼不更改
        {
            String strSQL = @"UPDATE [User] SET [Account] = @eAccount, [Name] = @eName, [Birthday] = @eBirthday, [Phone] = @ePhone, [Email] = @eEmail, [Rank] = @eRank WHERE [id] = @eID";
            cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        }
        else // 更改密碼
        {
            String strPassword = getMd5Method(((TextBox)btnCheck.Parent.FindControl("tbxPassword")).Text);
            String strSQL = @"UPDATE [User] SET [Account] = @eAccount, [Password] = @ePassword, [Name] = @eName, [Birthday] = @eBirthday, [Phone] = @ePhone, [Email] = @eEmail, [Rank] = @eRank WHERE [id] = @eID";
            cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@ePassword", SqlDbType.NVarChar).Value = strPassword;
        }
        
        cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = strAccount;
        cmd.Parameters.Add("@eName", SqlDbType.NChar).Value = strName;
        cmd.Parameters.Add("@eBirthday", SqlDbType.DateTime).Value = Convert.ToDateTime(strBirthday);
        cmd.Parameters.Add("@ePhone", SqlDbType.NChar).Value = strPhone;
        cmd.Parameters.Add("@eEmail", SqlDbType.NVarChar).Value = strEmail;
        cmd.Parameters.Add("@eRank", SqlDbType.Int).Value = strRank;
        cmd.Parameters.Add("@eID", SqlDbType.Int).Value = strID;
        SqlDataReader dataUser = cmd.ExecuteReader();
        conn.Close();
        lvAccount.DataBind();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ImageButton btnCancel = (ImageButton)sender;
        Label lblAccount = (Label)btnCancel.Parent.FindControl("lblAccount");
        Label lblPassword = (Label)btnCancel.Parent.FindControl("lblPassword");
        Label lblName = (Label)btnCancel.Parent.FindControl("lblName");
        Label lblBirthday = (Label)btnCancel.Parent.FindControl("lblBirthday");
        Label lblPhone = (Label)btnCancel.Parent.FindControl("lblPhone");
        Label lblEmail = (Label)btnCancel.Parent.FindControl("lblEmail");
        Label lblRank = (Label)btnCancel.Parent.FindControl("lblRank");
        TextBox tbxAccount = (TextBox)btnCancel.Parent.FindControl("tbxAccount");
        TextBox tbxPassword = (TextBox)btnCancel.Parent.FindControl("tbxPassword");
        TextBox tbxName = (TextBox)btnCancel.Parent.FindControl("tbxName");
        TextBox tbxBirthday = (TextBox)btnCancel.Parent.FindControl("tbxBirthday");
        TextBox tbxPhone = (TextBox)btnCancel.Parent.FindControl("tbxPhone");
        TextBox tbxEmail = (TextBox)btnCancel.Parent.FindControl("tbxEmail");
        TextBox tbxRank = (TextBox)btnCancel.Parent.FindControl("tbxRank");
        ImageButton btnDelete = (ImageButton)btnCancel.Parent.FindControl("btnDelete");
        ImageButton btnCheck = (ImageButton)btnCancel.Parent.FindControl("btnCheck");
        ImageButton btnEdit = (ImageButton)btnCancel.Parent.FindControl("btnEdit");
        lblAccount.Visible = true;
        lblPassword.Visible = true;
        lblName.Visible = true;
        lblBirthday.Visible = true;
        lblPhone.Visible = true;
        lblEmail.Visible = true;
        lblRank.Visible = true;
        tbxAccount.Visible = false;
        tbxPassword.Visible = false;
        tbxName.Visible = false;
        tbxBirthday.Visible = false;
        tbxPhone.Visible = false;
        tbxEmail.Visible = false;
        tbxRank.Visible = false;
        btnDelete.Visible = false;
        btnEdit.Visible = true;
        btnCheck.Visible = false;
        btnCancel.Visible = false;
        lvAccount.DataBind();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        ImageButton btnCancel = (ImageButton)sender;
        String strID = ((Label)btnCancel.Parent.FindControl("lblID")).Text;

        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"DELETE [User] WHERE [id] = @eID";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eID", SqlDbType.NVarChar).Value = strID;
        SqlDataReader dataUser = cmd.ExecuteReader();

        conn.Close();
        lvAccount.DataBind();
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        ImageButton btnEdit = (ImageButton)sender;
        Label lblAccount = (Label)btnEdit.Parent.FindControl("lblAccount");
        Label lblPassword = (Label)btnEdit.Parent.FindControl("lblPassword");
        Label lblName = (Label)btnEdit.Parent.FindControl("lblName");
        Label lblBirthday = (Label)btnEdit.Parent.FindControl("lblBirthday");
        Label lblPhone = (Label)btnEdit.Parent.FindControl("lblPhone");
        Label lblEmail = (Label)btnEdit.Parent.FindControl("lblEmail");
        Label lblRank = (Label)btnEdit.Parent.FindControl("lblRank");
        Label lblintRank = (Label)btnEdit.Parent.FindControl("lblintRank");
        TextBox tbxAccount = (TextBox)btnEdit.Parent.FindControl("tbxAccount");
        TextBox tbxPassword = (TextBox)btnEdit.Parent.FindControl("tbxPassword");
        TextBox tbxName = (TextBox)btnEdit.Parent.FindControl("tbxName");
        TextBox tbxBirthday = (TextBox)btnEdit.Parent.FindControl("tbxBirthday");
        TextBox tbxPhone = (TextBox)btnEdit.Parent.FindControl("tbxPhone");
        TextBox tbxEmail = (TextBox)btnEdit.Parent.FindControl("tbxEmail");
        TextBox tbxRank = (TextBox)btnEdit.Parent.FindControl("tbxRank");
        ImageButton btnDelete = (ImageButton)btnEdit.Parent.FindControl("btnDelete");
        ImageButton btnCheck = (ImageButton)btnEdit.Parent.FindControl("btnCheck");
        ImageButton btnCancel = (ImageButton)btnEdit.Parent.FindControl("btnCancel");
        lblAccount.Visible = false;
        lblPassword.Visible = false;
        lblName.Visible = false;
        lblBirthday.Visible = false;
        lblPhone.Visible = false;
        lblEmail.Visible = false;
        lblRank.Visible = false;
        tbxAccount.Visible = true;
        tbxPassword.Visible = true;
        tbxName.Visible = true;
        tbxBirthday.Visible = true;
        tbxPhone.Visible = true;
        tbxEmail.Visible = true;
        tbxRank.Visible = true;
        btnDelete.Visible = true;
        btnEdit.Visible = false;
        btnCheck.Visible = true;
        btnCancel.Visible = true;
        tbxAccount.Text = lblAccount.Text;
        tbxPassword.Text = lblPassword.Text;
        tbxName.Text = lblName.Text;
        tbxBirthday.Text = lblBirthday.Text;
        DateTime dt = Convert.ToDateTime(lblBirthday.Text);
        tbxBirthday.Text = dt.ToString("yyyy-MM-dd");
        tbxPhone.Text = lblPhone.Text;
        tbxEmail.Text = lblEmail.Text;
        tbxRank.Text = lblintRank.Text;
    }
    private string getMd5Method(string input)
    {
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();

        byte[] myData = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));
        StringBuilder sBuilder = new StringBuilder();

        for (int i = 0; i < myData.Length; i++)
        {
            sBuilder.Append(myData[i].ToString("x"));
        }

        return string.Format("{0}", sBuilder.ToString());
    }
}