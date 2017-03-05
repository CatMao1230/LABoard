using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
using System.Text;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        String Account = tbxAccount.Text;
        String Password = tbxPassword.Text;
        
        SqlConnection conn = new SqlConnection("Data Source=DESKTOP-5NI00BA;Initial Catalog=LABoard;Integrated Security=True");
        conn.Open();
        String strSQL = @"SELECT * FROM [User] WHERE Account = @eAccount";
        SqlCommand cmd = new SqlCommand(strSQL, conn); //建立 SQL 命令對象
        cmd.Parameters.Add("@eAccount", SqlDbType.NVarChar).Value = Account;
        SqlDataReader data = cmd.ExecuteReader();
        lblResult.Text = "帳號密碼有誤。";
        if (data.Read())
        {
            if (data["Password"].ToString() == getMd5Method(Password))
            {
                // Login Success!
                Session["Account"] = Account;
                Session["Rank"] = data["Rank"].ToString();
                if (int.Parse(Session["Rank"].ToString()) == 0)
                {
                    Response.Write("<Script language='JavaScript'>alert('等候管理員批准。'); document.location.href='Login.aspx';</Script>");
                }
                else
                {
                    Response.Redirect("MessageBoard.aspx");
                }
            }
        }
      
        conn.Close();
    }
    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        Response.Redirect("SignUp.aspx");
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