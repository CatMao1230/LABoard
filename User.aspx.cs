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

public partial class User : System.Web.UI.Page
{
    Boolean isLogin = false;
    String Name;
    String[] arrRank = { "待審核", "低階會員", "中階會員", "高階會員", "管理員", "站長" };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
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

                    lblID.Text = dataUser["id"].ToString();
                    imgPicture.ImageUrl = "Image/" + Session["Account"].ToString() + ".jpg";
                    tbxAccount.Text = dataUser["Account"].ToString();
                    tbxPassword.Text = "";
                    tbxName.Text = dataUser["Name"].ToString().Trim();
                    DateTime dt = (DateTime)dataUser["Birthday"];
                    tbxBirthday.Text = dt.ToString("yyyy/MM/dd");
                    tbxTel.Text = dataUser["Phone"].ToString();
                    tbxEmail.Text = dataUser["Email"].ToString();
                    tbxRank.Text = arrRank[(int)dataUser["Rank".ToString()]].ToString();
                }

                conn.Close();
            }
            else // 非法登入
            {
                isLogin = false;
                Response.Redirect("Login.aspx");
            }
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");

        conn.Open();

        if(tbxPassword.Text == "") // 若為空白不更改密碼
        {
            String strSQL = @"UPDATE [User] SET [Name] = @eName, [Phone] = @ePhone, [Email] = @eEmail WHERE [id] = @eID";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@eName", SqlDbType.NChar).Value = tbxName.Text;
            cmd.Parameters.Add("@ePhone", SqlDbType.NChar).Value = tbxTel.Text;
            cmd.Parameters.Add("@eEmail", SqlDbType.NVarChar).Value = tbxEmail.Text;
            cmd.Parameters.Add("@eID", SqlDbType.Int).Value = lblID.Text;
            SqlDataReader dataUser = cmd.ExecuteReader();
        }
        else // 更改密碼
        {
            String strSQL = @"UPDATE [User] SET [Password] = @ePassword, [Name] = @eName, [Phone] = @ePhone, [Email] = @eEmail WHERE [id] = @eID";
            SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
            cmd.Parameters.Add("@ePassword", SqlDbType.NVarChar).Value = getMd5Method(tbxPassword.Text);
            cmd.Parameters.Add("@eName", SqlDbType.NChar).Value = tbxName.Text;
            cmd.Parameters.Add("@ePhone", SqlDbType.NChar).Value = tbxTel.Text;
            cmd.Parameters.Add("@eEmail", SqlDbType.NVarChar).Value = tbxEmail.Text;
            cmd.Parameters.Add("@eID", SqlDbType.Int).Value = lblID.Text;
            SqlDataReader dataUser = cmd.ExecuteReader();
        }

        conn.Close();

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